# PPU Connect — Domain Models Reference

> **Architecture layer**: Domain (pure Dart — zero Flutter/HTTP imports)
> All entities are immutable value objects using `freezed`. Enums are exhaustive sealed types.
> IDs are `String` (Firestore document IDs). Timestamps are `DateTime` (UTC).

---

## Entity Relationship Overview

```
User ──────────────── TutorProfile (1:0..1)
 │                         │
 │                    WeeklySlot[] (1:N)
 │
 ├── TutoringRequest[] (as seeker, 1:N)
 │
 ├── AppointmentRequest[] (as sender or receiver, 1:N)
 │        │
 │        └── Appointment (1:0..1 on acceptance)
 │                 │
 │                 ├── SessionConfirmation (1:1)
 │                 └── Payment (1:1, simulated)
 │
 ├── Review[] (as author or subject, 1:N)
 ├── Report[] (as reporter, 1:N)
 └── AppNotification[] (1:N)
```

---

## Enumerations

### `UserRole`
```dart
enum UserRole { seeker, tutor, both }
```
| Value  | Description |
|--------|-------------|
| `seeker` | Only looking for help |
| `tutor`  | Only offering help |
| `both`   | Can do both in different subjects |

---

### `AcademicLevel`
```dart
enum AcademicLevel { firstYear, secondYear, thirdYear, fourthYear, fifthYear, graduate }
```

---

### `AppointmentStatus`
```dart
enum AppointmentStatus { confirmed, cancelled, completed, expired }
```
| Value       | Description |
|-------------|-------------|
| `confirmed` | Both parties agreed, session is upcoming |
| `cancelled` | Cancelled by a party (only allowed > 4 h before session) |
| `completed` | Session has ended and both parties confirmed attendance |
| `expired`   | Request not confirmed ≥ 1 h before session; auto-set by backend |

---

### `RequestStatus`
```dart
enum RequestStatus { pending, accepted, rejected, cancelled, expired }
```

---

### `SessionOutcome`
```dart
enum SessionOutcome { completed, seekerAbsent, tutorAbsent, bothAbsent, disputed }
```

---

### `PaymentStatus`
```dart
enum PaymentStatus { pending, released, refunded, held }
```

---

### `ReportStatus`
```dart
enum ReportStatus { open, underReview, resolved, dismissed }
```

---

### `NotificationType`
```dart
enum NotificationType {
  appointmentRequest,
  appointmentConfirmed,
  appointmentCancelled,
  appointmentExpired,
  sessionStartingSoon,
  sessionConfirmationRequired,
  paymentReleased,
  paymentRefunded,
  newReview,
  reportUpdate,
  tutoringRequestMatch,
}
```

---

## Core Entities

---

### 1. `User`

Represents every registered student on the platform.

| Field | Type | Constraints |
|-------|------|-------------|
| `id` | `String` | Firestore document ID, immutable |
| `fullName` | `String` | Non-empty, max 100 chars |
| `email` | `String` | Valid university email, unique |
| `phoneNumber` | `String?` | Optional, E.164 format |
| `avatarUrl` | `String?` | Firebase Storage URL |
| `major` | `String` | Non-empty |
| `academicLevel` | `AcademicLevel` | Required |
| `gpa` | `double?` | 0.0 – 4.0 (or local scale); optional, self-reported |
| `role` | `UserRole` | Required; determines which features are accessible |
| `isActive` | `bool` | False = soft-deleted / suspended |
| `reportCount` | `int` | Incremented on each confirmed report; default 0 |
| `createdAt` | `DateTime` | UTC, set on registration |
| `updatedAt` | `DateTime` | UTC, updated on every profile change |

**Business rules:**
- A `User` with `role == UserRole.seeker` cannot have a `TutorProfile`.
- `reportCount >= 3` triggers an automatic account review (handled by backend).
- `email` must match the PPU domain pattern (validation in domain layer).

---

### 2. `TutorProfile`

Extended profile attached to any `User` who can tutor.  
One-to-one with `User`; stored as a sub-collection or embedded document.

| Field | Type | Constraints |
|-------|------|-------------|
| `userId` | `String` | FK → `User.id`; also the document ID |
| `bio` | `String?` | Optional, max 500 chars |
| `subjects` | `List<String>` | Min 1 subject; free-text or from a catalogue |
| `hourlyRate` | `double` | Simulated; ≥ 0.0 |
| `currency` | `String` | ISO 4217, default `"ILS"` |
| `averageRating` | `double` | Computed field; 0.0 – 5.0; default 0.0 |
| `totalReviews` | `int` | Counter; default 0 |
| `completedSessions` | `int` | Incremented on `SessionOutcome.completed`; default 0 |
| `isAcceptingRequests` | `bool` | Tutor can pause intake; default `true` |
| `weeklySlots` | `List<WeeklySlot>` | Embedded; defines recurring availability |
| `createdAt` | `DateTime` | UTC |
| `updatedAt` | `DateTime` | UTC |

**Business rules:**
- `weeklySlots` must not overlap within the same tutor.
- If `isAcceptingRequests == false`, new `AppointmentRequest` targeting this tutor is rejected at the domain level.

---

### 3. `WeeklySlot`

A recurring weekly availability block defined by a tutor.  
Embedded inside `TutorProfile.weeklySlots`.

| Field | Type | Constraints |
|-------|------|-------------|
| `id` | `String` | UUID generated client-side |
| `dayOfWeek` | `int` | 1 = Monday … 7 = Sunday (ISO 8601) |
| `startTime` | `TimeOfDay` | 24 h; must be before `endTime` |
| `endTime` | `TimeOfDay` | 24 h; min duration 30 min |
| `isActive` | `bool` | Tutor can disable a slot without deleting; default `true` |

**Business rules:**
- No two `WeeklySlot` entries for the same tutor may overlap on the same `dayOfWeek`.
- A slot marked `isActive == false` is hidden from seekers.

---

### 4. `TutoringRequest`

A public broadcast from a seeker asking for help. Any matching tutor may respond.

| Field | Type | Constraints |
|-------|------|-------------|
| `id` | `String` | Firestore document ID |
| `seekerId` | `String` | FK → `User.id` |
| `subject` | `String` | Non-empty |
| `description` | `String` | Non-empty, max 1 000 chars |
| `preferredDays` | `List<int>` | ISO weekday integers; optional |
| `preferredTimeRange` | `TimeRange?` | Preferred window; optional |
| `status` | `RequestStatus` | Default `pending` |
| `respondedTutorIds` | `List<String>` | Tutors who sent an `AppointmentRequest` in response |
| `expiresAt` | `DateTime` | UTC; auto-set to `createdAt + 7 days` if not fulfilled |
| `createdAt` | `DateTime` | UTC |
| `updatedAt` | `DateTime` | UTC |

**Business rules:**
- A seeker may have at most **3 open** `TutoringRequest` entries simultaneously.
- Transitions: `pending → accepted` (when an `AppointmentRequest` is confirmed) or `pending → expired` (after `expiresAt`).

---

### 5. `AppointmentRequest`

A direct request from one party to another to schedule a session.  
Can be initiated by either the seeker or the tutor.

| Field | Type | Constraints |
|-------|------|-------------|
| `id` | `String` | Firestore document ID |
| `senderId` | `String` | FK → `User.id` |
| `receiverId` | `String` | FK → `User.id` |
| `tutorId` | `String` | FK → `User.id`; always the tutor party |
| `seekerId` | `String` | FK → `User.id`; always the seeker party |
| `subject` | `String` | Non-empty |
| `note` | `String?` | Optional message, max 500 chars |
| `proposedStartAt` | `DateTime` | UTC; must be a future time |
| `proposedEndAt` | `DateTime` | UTC; must be > `proposedStartAt`; min duration 30 min |
| `status` | `RequestStatus` | Default `pending` |
| `linkedTutoringRequestId` | `String?` | Set if request was created in response to a `TutoringRequest` |
| `expiresAt` | `DateTime` | UTC; auto = `proposedStartAt - 1 hour` (hard deadline per business rule) |
| `createdAt` | `DateTime` | UTC |
| `updatedAt` | `DateTime` | UTC |

**Business rules:**
- A `pending` request automatically transitions to `expired` if `DateTime.now() >= expiresAt` and it has not been `accepted`.
- A tutor with `isAcceptingRequests == false` cannot receive new requests.
- There must be no confirmed `Appointment` overlapping `[proposedStartAt, proposedEndAt]` for either party (double-booking prevention).
- Acceptance creates exactly one `Appointment` and one `Payment` record atomically (Firestore transaction).

---

### 6. `Appointment`

A confirmed, scheduled tutoring session. Created only from an accepted `AppointmentRequest`.

| Field | Type | Constraints |
|-------|------|-------------|
| `id` | `String` | Firestore document ID |
| `appointmentRequestId` | `String` | FK → `AppointmentRequest.id`; immutable |
| `tutorId` | `String` | FK → `User.id`; immutable |
| `seekerId` | `String` | FK → `User.id`; immutable |
| `subject` | `String` | Immutable after confirmation |
| `startAt` | `DateTime` | UTC; immutable after confirmation |
| `endAt` | `DateTime` | UTC; immutable after confirmation |
| `status` | `AppointmentStatus` | Default `confirmed` |
| `cancelledBy` | `String?` | `User.id` of canceller; set on cancellation |
| `cancelledAt` | `DateTime?` | UTC |
| `cancellationReason` | `String?` | Optional, max 300 chars |
| `createdAt` | `DateTime` | UTC |
| `updatedAt` | `DateTime` | UTC |

**Business rules:**
- Cancellation is **not allowed** if `DateTime.now() >= startAt - 4 hours`.
- An `Appointment` transitions to `expired` only if its `AppointmentRequest` expired before acceptance (should not happen if creation is atomic, but guard on read).
- Completion requires a matching `SessionConfirmation` where both parties have confirmed.

---

### 7. `SessionConfirmation`

Tracks post-session attendance and mutual completion confirmation.  
One-to-one with `Appointment`; created immediately when the `Appointment` is created.

| Field | Type | Constraints |
|-------|------|-------------|
| `id` | `String` | Same as `Appointment.id` (document ID) |
| `appointmentId` | `String` | FK → `Appointment.id` |
| `tutorConfirmed` | `bool` | Default `false` |
| `seekerConfirmed` | `bool` | Default `false` |
| `tutorConfirmedAt` | `DateTime?` | UTC |
| `seekerConfirmedAt` | `DateTime?` | UTC |
| `outcome` | `SessionOutcome?` | Set when both sides have responded or deadline passes |
| `resolvedAt` | `DateTime?` | UTC; when `outcome` was determined |

**Business rules:**
- Both parties have a window of **24 hours after `Appointment.endAt`** to confirm.
- If only the tutor confirms → `SessionOutcome.seekerAbsent` → `Payment` released to tutor.
- If only the seeker confirms → `SessionOutcome.tutorAbsent` → `Payment` refunded to seeker.
- If neither confirms within 24 h → `SessionOutcome.disputed` → manual review.
- When both confirm → `SessionOutcome.completed` → `Payment` released to tutor; tutor's `completedSessions` incremented.

---

### 8. `Payment`

Simulated payment record. Created atomically with the `Appointment`.

| Field | Type | Constraints |
|-------|------|-------------|
| `id` | `String` | Firestore document ID |
| `appointmentId` | `String` | FK → `Appointment.id`; unique |
| `tutorId` | `String` | FK → `User.id` |
| `seekerId` | `String` | FK → `User.id` |
| `amount` | `double` | Computed: `TutorProfile.hourlyRate × session duration in hours`; ≥ 0 |
| `currency` | `String` | ISO 4217; copied from `TutorProfile.currency` |
| `status` | `PaymentStatus` | Default `held` |
| `releasedAt` | `DateTime?` | UTC; set when status → `released` |
| `refundedAt` | `DateTime?` | UTC; set when status → `refunded` |
| `createdAt` | `DateTime` | UTC |
| `updatedAt` | `DateTime` | UTC |

**Business rules:**
- `amount` is locked at creation time; changing `hourlyRate` later does not affect existing payments.
- Status transitions (driven by `SessionConfirmation.outcome`):
  - `held → released` on `completed` or `seekerAbsent`
  - `held → refunded` on `tutorAbsent`
  - Manual override possible for `disputed` outcome.

---

### 9. `Review`

A rating and comment left by a seeker for a tutor after a completed session.

| Field | Type | Constraints |
|-------|------|-------------|
| `id` | `String` | Firestore document ID |
| `appointmentId` | `String` | FK → `Appointment.id`; unique per review |
| `authorId` | `String` | FK → `User.id` (seeker) |
| `tutorId` | `String` | FK → `User.id` (tutor) |
| `rating` | `int` | 1 – 5 inclusive |
| `comment` | `String?` | Optional, max 500 chars |
| `isVisible` | `bool` | Hidden if the review is under report; default `true` |
| `createdAt` | `DateTime` | UTC |

**Business rules:**
- Only one `Review` per `Appointment` (enforced by unique index on `appointmentId`).
- A review can only be created if `SessionConfirmation.outcome == SessionOutcome.completed`.
- Creating a review triggers recalculation of `TutorProfile.averageRating` and `totalReviews` (Firestore transaction).

---

### 10. `Report`

A misconduct report raised by any user against another user.

| Field | Type | Constraints |
|-------|------|-------------|
| `id` | `String` | Firestore document ID |
| `reporterId` | `String` | FK → `User.id` |
| `reportedUserId` | `String` | FK → `User.id`; must differ from `reporterId` |
| `appointmentId` | `String?` | FK → `Appointment.id`; optional context |
| `reason` | `ReportReason` | Enum (see below) |
| `description` | `String` | Non-empty, max 1 000 chars |
| `status` | `ReportStatus` | Default `open` |
| `resolvedAt` | `DateTime?` | UTC |
| `adminNote` | `String?` | Internal note; not visible to reporter |
| `createdAt` | `DateTime` | UTC |

#### `ReportReason` enum
```dart
enum ReportReason {
  noShow,
  inappropriateBehavior,
  harassment,
  fraud,
  fakeProfile,
  other,
}
```

**Business rules:**
- A reporter may not submit more than **3 reports against the same user** in a 30-day window.
- On `status → resolved` with action taken, `User.reportCount` for the reported user is incremented.

---

### 11. `AppNotification`

In-app notification delivered to a single user.

| Field | Type | Constraints |
|-------|------|-------------|
| `id` | `String` | Firestore document ID |
| `userId` | `String` | FK → `User.id` (recipient) |
| `type` | `NotificationType` | Drives icon and routing |
| `title` | `String` | Non-empty, max 100 chars |
| `body` | `String` | Non-empty, max 300 chars |
| `payload` | `Map<String, String>` | Typed metadata (e.g., `appointmentId`, `requestId`) |
| `isRead` | `bool` | Default `false` |
| `readAt` | `DateTime?` | UTC |
| `createdAt` | `DateTime` | UTC |

---

## Value Objects

Small domain types that carry validation and have no identity of their own.

### `TimeRange`
```dart
// Represents an abstract preferred time window (not a concrete date)
class TimeRange {
  final TimeOfDay start;
  final TimeOfDay end;
  // Invariant: end > start
}
```

### `SessionDuration`
```dart
// Derived; computed from Appointment.startAt and endAt
// Used to calculate Payment.amount
class SessionDuration {
  final Duration value;
  // Invariant: value >= Duration(minutes: 30)
}
```

---

## Firestore Collection Structure

```
/users/{userId}
/users/{userId}/notifications/{notificationId}

/tutorProfiles/{userId}               ← document ID == userId

/tutoringRequests/{requestId}

/appointmentRequests/{requestId}

/appointments/{appointmentId}
/appointments/{appointmentId}/sessionConfirmation   ← single document

/payments/{paymentId}

/reviews/{reviewId}

/reports/{reportId}
```

**Composite indexes required:**
| Collection | Fields | Purpose |
|---|---|---|
| `appointmentRequests` | `tutorId ASC`, `status ASC`, `proposedStartAt ASC` | Availability conflict check |
| `appointmentRequests` | `seekerId ASC`, `status ASC`, `proposedStartAt ASC` | Seeker's pending requests |
| `appointments` | `tutorId ASC`, `status ASC`, `startAt ASC` | Tutor schedule view |
| `appointments` | `seekerId ASC`, `status ASC`, `startAt ASC` | Seeker schedule view |
| `tutoringRequests` | `status ASC`, `createdAt DESC` | Public feed |
| `reviews` | `tutorId ASC`, `createdAt DESC` | Tutor review list |

---

## Business Rule Summary

| # | Rule |
|---|------|
| BR-01 | `AppointmentRequest` expires automatically at `proposedStartAt - 1 h` if not accepted |
| BR-02 | Cancellation of a confirmed `Appointment` is blocked within the last **4 hours** before `startAt` |
| BR-03 | Double-booking is prevented by checking confirmed appointments for both parties before accepting a request (Firestore transaction) |
| BR-04 | If only the tutor confirms attendance, the seeker is marked absent; payment is released to the tutor |
| BR-05 | If only the seeker confirms attendance, the tutor is marked absent; payment is refunded to the seeker |
| BR-06 | Confirmation window closes **24 hours** after `Appointment.endAt`; unresolved cases become `disputed` |
| BR-07 | A `Review` can only be created after `SessionOutcome.completed` |
| BR-08 | `TutorProfile.averageRating` is always recomputed atomically with review creation/deletion |
| BR-09 | A seeker may have at most **3 open** `TutoringRequest` records simultaneously |
| BR-10 | `Payment.amount` is fixed at creation time regardless of later rate changes |
| BR-11 | A reporter may not file more than **3 reports** against the same user within 30 days |
| BR-12 | `User.reportCount >= 3` triggers an account review flag |
