# PPU Connect — Features, Pages, Components, Validations & Mixins

> **Architecture layer**: Presentation (`presentation/pages/`, `presentation/widgets/`)
> Each page is a route target. Components listed under a page are widgets used exclusively or primarily there.
> Shared components live in `core/widgets/` and are imported by any feature.

---

## Animation & 3D System Overview

| Tool | Use case |
|------|----------|
| `lottie` package | Complex vector illustrations, looping idle states, success/error feedback |
| `rive` package | Interactive state-machine animations (buttons, onboarding, role cards) |
| `flutter_animate` | Declarative chained micro-animations (stagger, shimmer, slide, scale) |
| `shimmer` package | Skeleton loading placeholders |
| `Transform.perspective` | 3D card tilt, perspective press effects |
| `Matrix4.rotationY/X` | Card flip, page-turn transitions |
| `Hero` widget | Avatar → profile, card → detail shared-element transitions |
| `PageRouteBuilder` | Shared-axis slide (lateral nav), vertical slide-up (modals) |
| Custom `CustomPainter` + `Impeller` shaders | Depth glow, gradient orbs, particle fields |

**Global animation constants:**
```dart
const kFastDuration   = Duration(milliseconds: 150);
const kMedDuration    = Duration(milliseconds: 300);
const kSlowDuration   = Duration(milliseconds: 500);
const kPageDuration   = Duration(milliseconds: 350);
const kLottieDuration = Duration(milliseconds: 800);
```

**Page transitions:**
- Lateral navigation (push/pop): `SharedAxisTransition` horizontal, 350 ms, `fastOutSlowIn`
- Modal bottom sheet / dialog: slide-up + fade, 300 ms, `easeOut`
- Auth → Home shell: fade + scale (1.02 → 1.0), 400 ms

---

## Table of Contents

1. [Feature Pages & Components](#feature-pages--components)
2. [Shared Components](#shared-components)
3. [Validations](#validations)
4. [Mixins](#mixins)

---

# Feature Pages & Components

---

## 1. Authentication

---

### `SplashPage`
**Route:** `/` (initial route)
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `AppLogo` | Animated logo shown during auth check | **Lottie** logo-reveal (scale 0.6→1.0 + opacity, 1200 ms, `easeOutBack`); idle float loop (translateY ±6 dp, 2 s, `Curves.easeInOut`, repeat); on auth-check complete, fade-out (300 ms) |
| `LoadingIndicator` | Centered circular indicator | Custom 3-ring concentric loader: outer ring `RotationTransition` 1.4 s, middle 1.0 s (reverse), inner 0.7 s; rings have varying opacity (0.3–1.0) creating depth illusion |

---

### `WelcomePage`
**Route:** `/welcome`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `AppLogo` | Large centered logo | Stagger entry: logo slides-down from -20 dp + fade, 500 ms `easeOut`; idle float loop (4 s, ±4 dp) after entry settles |
| `OnboardingIllustration` | SVG hero image | **Rive** state machine: idle state plays looping 3D-depth parallax (foreground layer moves 2× faster than background on gyroscope/scroll input); entry: scale 0.9→1.0 + fade, 600 ms `easeOutCubic` |
| `PrimaryButton` | "Login" CTA | Slide-up + fade entry (delay 200 ms after logo); tap: `ScaleTransition` 1.0→0.95→1.0 (80 ms down, 150 ms up) + `InkWell` ripple; shimmer sweep on first render (300 ms, once) |
| `OutlinedButton` | "Register" CTA | Same entry stagger (+100 ms delay vs PrimaryButton); tap scale identical; border color animate on focus (200 ms) |
| `AppVersionLabel` | Small version text at bottom | Fade-in last (delay 400 ms, 300 ms fade) |

---

### `LoginPage`
**Route:** `/login`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `EmailTextField` | With PPU-domain hint | Focus: border color + width animates (1 dp→2 dp, 200 ms `easeOut`); label float-up (standard Material); entry slide-down + fade (stagger 0 ms) |
| `PasswordTextField` | With show/hide toggle icon | Same focus animation; eye-icon: `RotationTransition` 0→π/2 (200 ms) on toggle; entry stagger +80 ms |
| `PrimaryButton` | "Login" submit | Loading state: text cross-fades to `CircularProgressIndicator` (200 ms); success: scale 1.0→1.05→1.0 + green flash (300 ms) |
| `TextLinkButton` | "Forgot Password?" → `ForgotPasswordPage` | Tap: opacity 1.0→0.5→1.0 (100 ms) + underline width 0→full (150 ms) |
| `TextLinkButton` | "Don't have an account? Register" | Same as above |
| `ErrorBanner` | Inline error strip (wrong credentials, suspended) | **Entry**: slide-down from -100% + fade (300 ms, `easeOut`); **shake**: horizontal translateX ±8 dp × 3 cycles (400 ms, `Curves.elasticOut`); **dismiss**: slide-up + fade (200 ms) |
| `LoadingOverlay` | Covers form during auth request | Backdrop: `BackdropFilter(ImageFilter.blur)` 0→6.0 + fade-in (200 ms); spinner: `ScaleTransition` 0.0→1.0 (250 ms, `easeOutBack`) |

---

### `RegisterPage`
**Route:** `/register`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `FullNameTextField` | Name input | Entry stagger 0 ms; focus animation same as LoginPage |
| `EmailTextField` | PPU domain validated | Entry stagger +60 ms; invalid domain: border flash red (300 ms pulse × 2) |
| `PasswordTextField` | With strength indicator | Entry stagger +120 ms |
| `PasswordStrengthBar` | Visual bar: weak / fair / strong | Width `TweenAnimationBuilder` (400 ms, `easeOut`); color cross-fade: red→orange→green (300 ms each); 3D depth: bar has inner glow shadow that intensifies with strength |
| `ConfirmPasswordTextField` | Must match password | Entry stagger +180 ms; match-success: brief green border flash (200 ms) |
| `PrimaryButton` | "Create Account" submit | Disabled state: opacity 0.4 (200 ms transition); enabled: slide subtle upward +2 dp via shadow elevation change; loading/success same as LoginPage |
| `ErrorBanner` | Email already in use, network error | Identical to LoginPage ErrorBanner |
| `LoadingOverlay` | During registration call | Identical to LoginPage LoadingOverlay |

---

### `ForgotPasswordPage`
**Route:** `/forgot-password`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `EmailTextField` | Input for reset email | Standard focus animation |
| `PrimaryButton` | "Send Reset Link" | Loading state with cross-fade to spinner |
| `SuccessStateWidget` | Shown after successful email send | **Lottie** email-sent illustration (envelope flies out with paper-plane trail, 1200 ms, plays once); content below fades in staggered after Lottie frame 30 |
| `ErrorBanner` | Email not found, network error | Same slide-down + shake as LoginPage |

---

## 2. Onboarding & Profile Setup

---

### `ProfileSetupPage` *(multi-step wizard)*
**Route:** `/onboarding`

**Wizard shell components:**
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `SetupProgressBar` | Step dots or linear progress | Active dot: `ScaleTransition` 1.0→1.5 + color fill (300 ms, `easeOut`); completed dot: checkmark draw via `CustomPainter` path animation (400 ms); progress line: width `TweenAnimationBuilder` (500 ms, `easeInOut`) |
| `SetupStepTitle` | Current step heading | Cross-fade between step titles (200 ms `FadeTransition`); new title slides-in from right on forward, left on back |
| `WizardNavBar` | Back / Next / Skip footer row | Next button: shimmer pulse on first appearance; tap scale 0.96 (80 ms); forward step: shared-axis horizontal transition on page content (300 ms) |

**Step 1 — `SetupPersonalInfoStep`:**
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `AvatarUploadWidget` | Camera/gallery picker with crop; shows initials fallback | **3D card flip** on photo selection: `Matrix4.rotationY` 0→π (600 ms, `easeInOut`) — front face shows initials, back face shows selected photo; idle avatar: subtle scale breathing loop (1.0↔1.02, 3 s); upload progress: circular progress overlay with `StrokeCap.round` animated arc |
| `FullNameTextField` | Pre-filled from registration | Entry slide-down + fade (stagger 100 ms after avatar) |
| `PhoneTextField` | Optional, E.164 format | Entry stagger +160 ms |

**Step 2 — `SetupAcademicInfoStep`:**
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `MajorDropdown` | Searchable dropdown of PPU majors | Dropdown open: items stagger-fade-in (30 ms each, 200 ms max); selected item: scale 1.0→1.03 flash (150 ms); search filter: items slide-out (filtered) + slide-in (matched) 200 ms |
| `AcademicLevelSelector` | Segmented buttons: Year 1–5 + Graduate | Selection indicator: `AnimatedPositioned` slide to selected segment (250 ms, `easeInOut`); deselected labels: opacity 0.6 (150 ms); selected: opacity 1.0 + scale 1.05 (150 ms) |
| `GpaTextField` | Optional; 0.0–4.0 numeric | On valid input: border morphs to green (300 ms); on out-of-range: shake (400 ms) |

**Step 3 — `SetupRoleStep`:**
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `RoleSelectionCard` | One card per role (Seeker / Tutor / Both) with icon + explanation | **3D perspective tilt**: `Transform.perspective(1000)` with `Matrix4.rotationX/Y` ±8° on press/hover (150 ms, `easeOut`); **depth shadow**: `BoxShadow` 4 dp → 12 dp elevation on select; selected: border color animate + checkmark `ScaleTransition` 0→1 (300 ms, `easeOutBack`); **Rive** icon on each card: Seeker (person looking), Tutor (graduation cap), Both (people) — idle loop, triggers play animation on select |
| `RoleInfoTooltip` | Expandable help text per role | `SizeTransition` + `FadeTransition` (250 ms, `easeOut`); tooltip arrow rotates 180° on expand (200 ms) |

**Step 4 — `SetupTutorDetailsStep`** *(Tutor / Both only):*
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `SubjectMultiSelectInput` | Chip-based multi-select with free-text add | New chip: `ScaleTransition` 0→1 + fade (200 ms, `easeOutBack`); remove chip: scale + fade out (150 ms); chips animate-reflow position using `AnimatedSize` |
| `HourlyRateTextField` | Numeric, with currency label | Currency label slides-in from right (200 ms); on valid rate: subtle green glow (300 ms) |
| `CurrencySelector` | Dropdown (ILS default) | Same stagger-fade-in dropdown as MajorDropdown |
| `BioTextArea` | 500-char multiline with `CharacterCounter` | `AnimatedContainer` height expands smoothly on focus (300 ms) |

**Step 5 — `SetupAvailabilityStep`** *(Tutor / Both only):*
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `WeeklyAvailabilityBuilder` | Editable 7-column grid | Day column: tap triggers column highlight `AnimatedContainer` (200 ms); grid has subtle 3D depth via `BoxShadow` gradient (top lighter, bottom darker) |
| `AddSlotInlineForm` | Inline day + time range row with add button | Slide-down from 0 height (300 ms, `easeOut`) on expand; time pickers slide in horizontally |
| `SlotChip` | Dismissible chip per saved slot | Same as SubjectMultiSelectInput chip animations; `Dismissible` swipe with red delete background fade |
| `OverlapWarningBanner` | Appears when a new slot conflicts | Slide-down + shake (same as ErrorBanner); orange left-border pulse (600 ms loop while conflict exists) |

**Step 6 — `SetupCompleteStep`:**
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `SetupSummaryCard` | Read-only recap of entered data | **3D card reveal**: card flips in (`Matrix4.rotationX` -π/2→0, 600 ms, `easeOutCubic`); card has layered `BoxShadow` creating floating depth effect; each row stagger-fades in (40 ms each) |
| `PrimaryButton` | "Start Using PPU Connect" | **Rive** button: idle shimmer; tap: particle burst from button center (Rive state trigger); scales 1.0→0.95→1.05→1.0 with spring curve |

---

## 3. User Profile

---

### `MyProfilePage`
**Route:** `/profile`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `ProfileAvatarHeader` | Large avatar, name, role badge | **Hero** animation from any `UserAvatar` in list; header parallax collapse on scroll (avatar shrinks 80 dp→48 dp, 300 ms); avatar has 3D depth ring (outer glow `BoxDecoration` with gradient shadow); name + role badge slide-up on page enter (stagger 200 ms, 300 ms `easeOut`) |
| `ProfileInfoCard` | Major, academic level, GPA row | Card slide-up + fade (delay 300 ms, 400 ms); **3D tilt** on press (±5°, `Transform.perspective`) |
| `TutorSummaryCard` | Rating, subjects, rate, accepting toggle | Stars animate in one-by-one (stagger 80 ms each, fill sweep `CustomPainter`); accepting toggle: `AnimatedSwitcher` with color cross-fade (300 ms) |
| `ActionButtonRow` | Edit Profile / Switch Role | Buttons slide-up stagger (delay 400 ms + 60 ms each) |
| `StatRowWidget` | Completed sessions count | Number counter animation: `TweenAnimationBuilder<int>` counts up from 0 (800 ms, `easeOut`) on first render |
| `LogoutListTile` | With confirmation dialog | Tap: red color flash (200 ms); dialog: scale + fade-in (200 ms, `easeOutBack`) |

---

### `EditProfilePage`
**Route:** `/profile/edit`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `AvatarUploadWidget` | Replace existing avatar | 3D flip same as SetupPersonalInfoStep; on new photo load, cross-fade old→new (400 ms) |
| `FullNameTextField` | Editable | Standard focus + dirty-state indicator (border color shift to accent, 200 ms) |
| `PhoneTextField` | Optional, editable | Same as above |
| `EmailReadOnlyField` | Shown greyed-out, not editable | Lock icon pulse (scale 1.0→1.1→1.0, 300 ms) on tap-attempt |
| `MajorDropdown` | Editable | Same stagger dropdown |
| `AcademicLevelSelector` | Editable | Same segment slide |
| `GpaTextField` | Editable | Same validation animations |
| `SaveButton` | Disabled until a field changes | `AnimatedOpacity` 0.4→1.0 (300 ms) when first field is dirty; enabled: elevation lift animation |
| `UnsavedChangesDialog` | Shown on back if dirty | Scale + blur backdrop (200 ms) |

---

### `PublicProfilePage`
**Route:** `/profile/:userId`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `ProfileAvatarHeader` | Avatar, name, role badge | **Hero** transition from source card; parallax scroll collapse identical to MyProfilePage |
| `ProfileInfoCard` | Major, level | Slide-up + fade (delay 200 ms) |
| `TutorProfileCard` | Rating, subjects, rate, bio | Card slide-up (delay 300 ms); stars fill-in stagger |
| `SubjectChipList` | Horizontal scrollable chips | Chips stagger-fade-in left-to-right (30 ms each, 200 ms) on page enter |
| `RatingStars` | Display-only with numeric | Star fill sweep `CustomPainter` animated (600 ms, `easeOut`) on page enter |
| `ReviewsPreviewList` | First 3 reviews with "See All" link | Review cards stagger slide-up (60 ms each, 300 ms per card) |
| `SendAppointmentRequestButton` | → `CreateAppointmentRequestPage` | Persistent bottom CTA: slide-up from off-screen (400 ms, `easeOutCubic`) after page settles; **Rive** idle shimmer |
| `ReportUserButton` | → `ReportUserPage` | Tap: red opacity flash (200 ms) |

---

## 4. Tutor Profile & Availability

---

### `TutorProfileEditPage`
**Route:** `/tutor-profile/edit`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `BioTextArea` | 500-char multiline with `CharacterCounter` | `AnimatedContainer` height grow on focus; character counter color cross-fade (300 ms) at 90% |
| `SubjectMultiSelectInput` | Add / remove subjects | Chip appear/disappear with spring scale (same as SetupTutorDetailsStep) |
| `HourlyRateTextField` | Numeric with currency | On change: rate preview updates with counter animation |
| `CurrencySelector` | Dropdown | Stagger dropdown open |
| `AcceptingRequestsSwitch` | Toggle `isAcceptingRequests` | **Rive** toggle: track color animates green↔grey + thumb slides with spring overshoot (200 ms); label cross-fades "Accepting" ↔ "Paused" (200 ms) |
| `SaveButton` | Disabled until dirty | Same animated opacity + elevation as EditProfilePage |

---

### `WeeklyAvailabilityPage`
**Route:** `/tutor-profile/availability`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `WeeklyAvailabilityGrid` | Read-only 7-column summary view | Grid cells: stagger reveal column-by-column (40 ms each); active slots: top-to-bottom fill animation (300 ms) with accent color |
| `SlotListView` | Full list of `WeeklySlot` entries | `AnimatedList` — insert/remove with `SizeTransition` + `FadeTransition` (250 ms) |
| `SlotCard` | Day, time range, active toggle, edit / delete actions | Slide-in from right on insert (250 ms); toggle: same Rive toggle as AcceptingRequestsSwitch; edit/delete icons: `FadeTransition` reveal on swipe-to-reveal (200 ms) |
| `AddSlotFAB` | → `AddEditSlotPage` | **Rive** FAB: idle has + icon; tap: icon morphs to checkmark; expand pulse on scroll-up reveal |
| `EmptyStateWidget` | "No availability set yet" | **Lottie** empty-calendar illustration (looping idle, person looking at blank calendar); fade-in (300 ms) |

---

### `AddEditSlotPage`
**Route:** `/tutor-profile/availability/slot`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `DayOfWeekDropdown` | Monday–Sunday selector | Stagger dropdown open (30 ms per item); selection: accent fill sweep (200 ms) |
| `TimeRangePicker` | Start time + end time pickers as a unit | Time dials: `CupertinoPicker`-style 3D drum-roll spin (native); duration bar between start/end times animates width (300 ms) |
| `DurationDisplay` | Computed read-only "Xh Ym" label | `AnimatedSwitcher` flip-up digit change (100 ms per digit, like flip clock) |
| `OverlapWarningBanner` | Live conflict check against existing slots | Slide-down + orange shake (identical to SetupAvailabilityStep); fades out when conflict resolved (200 ms) |
| `SaveButton` | Disabled while overlap exists or duration < 30 min | Same disabled/enabled animation |

---

## 5. Discovery — Browse Tutors

---

### `BrowseTutorsPage`
**Route:** `/discover/tutors`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `SearchBar` | Name or subject keyword search | Focus: expand width slightly (280 dp→320 dp, 200 ms); clear button: `ScaleTransition` appear (150 ms); typing: results appear with fade (200 ms) |
| `FilterBar` | Subject, Academic Level, Min Rating, Available Day chips | Active chip: scale 1.0→1.08 + filled color (200 ms); chip scroll: fade-edges mask left/right; new filter: chip slides in from right (200 ms) |
| `SortDropdown` | Rating / Rate low-high / Rate high-low / Most sessions | Dropdown: same stagger-fade as MajorDropdown; label cross-fade on selection (150 ms) |
| `TutorCardList` | Paginated list | **Stagger entry**: cards slide-up + fade from bottom (40 ms offset per card, max 300 ms); pagination load: new cards slide-up below existing ones |
| `TutorCard` | Avatar, name, major, rating stars, subject chips, hourly rate, "View" button | **3D tilt on press**: `Transform.perspective(1500)` rotate X/Y ±6° (100 ms, `easeOut`), returns to flat on release (200 ms); elevation: `BoxShadow` 2 dp→8 dp (150 ms); **Hero** on avatar for profile transition; button: scale press; stars: display-only (no animation in list) |
| `LoadingShimmerList` | Skeleton placeholders during fetch | `Shimmer` package: shimmer sweep direction left→right (1200 ms, `linear`, `repeat`); card shape matches TutorCard skeleton |
| `EmptyStateWidget` | "No tutors match your filters" | **Lottie** empty-search (magnifying glass finds nothing, loops); fade-in after 200 ms debounce |

---

### `TutorDetailPage`
**Route:** `/discover/tutors/:tutorId`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `TutorProfileHeader` | Large avatar, name, average rating, role badge | **Hero** from TutorCard avatar; header image parallax on scroll; avatar 3D depth ring glow; name + badge stagger-fade 200 ms |
| `HourlyRateDisplay` | Formatted amount + currency | Counter animation 0→rate (600 ms, `easeOut`) on page enter |
| `SubjectChipList` | All subjects | Horizontal stagger-appear (30 ms each) |
| `BioSection` | Bio text with expand/collapse | `SizeTransition` expand/collapse (300 ms, `easeInOut`); chevron rotates 180° (200 ms) |
| `WeeklyAvailabilityGrid` | Read-only availability view | Same stagger column reveal; available slots have pulsing green dot (2 s loop) |
| `ReviewsList` | Paginated `ReviewCard` list | Same stagger-slide as TutorCardList |
| `RatingDistributionBar` | 5→1 star bar chart | Each bar: width animates 0→value (stagger 80 ms each, 400 ms, `easeOut`); bars have 3D depth gradient (lighter top edge) |
| `SendRequestFAB` | "Request Session" → `CreateAppointmentRequestPage` | Slide-up from off-screen (400 ms, `easeOutCubic`) after page settles; **Rive** idle shimmer; tap: scale + particle burst |

---

## 6. Discovery — Browse Tutoring Requests

---

### `BrowseTutoringRequestsPage`
**Route:** `/discover/requests`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `SearchBar` | Subject keyword search | Same as BrowseTutorsPage SearchBar |
| `FilterBar` | Subject, Preferred Day, Seeker Level chips | Same filter chip animations |
| `SortDropdown` | Newest / Closest preferred day | Same stagger dropdown |
| `TutoringRequestCardList` | Paginated list | Same stagger slide-up entry (40 ms offset) |
| `TutoringRequestCard` | Seeker avatar + name, subject, description snippet, preferred day chips | **3D tilt** on press (same as TutorCard ±5°); **Hero** on seeker avatar; day chips fade-in stagger (30 ms each); new/fresh request badge: pulse glow (1.5 s loop, accent color) |
| `LoadingShimmerList` | Skeleton placeholders | Same Shimmer sweep |
| `EmptyStateWidget` | "No open requests right now" | **Lottie** empty-inbox (empty tray with floating question mark, loops) |

---

### `TutoringRequestDetailPage`
**Route:** `/discover/requests/:requestId`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `RequestHeader` | Subject, status badge, posted date | Slide-down + fade (300 ms); status badge scale-in (200 ms, `easeOutBack`) |
| `SeekerInfoCard` | Avatar, name, major, level | **Hero** on avatar; card slide-up (delay 200 ms, 300 ms) |
| `DescriptionSection` | Full description text | Fade-in (delay 300 ms, 400 ms); long text: expand with `SizeTransition` |
| `PreferredTimingSection` | Day chips + time range display | Day chips stagger-appear (30 ms each) |
| `RespondButton` | "Send Appointment Request" → `CreateAppointmentRequestPage` | Same persistent-CTA slide-up as TutorDetailPage; Rive shimmer idle |

---

## 7. Tutoring Requests

---

### `MyTutoringRequestsPage`
**Route:** `/requests/my`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `OpenRequestCountBadge` | "X / 3 open requests" | At-limit (3/3): badge turns red with pulse glow (1.5 s loop); count change: flip-up digit animation (200 ms) |
| `StatusTabBar` | Open / Fulfilled / Expired | Tab indicator slide (250 ms, `easeInOut`); content cross-fade on tab switch (200 ms) |
| `MyTutoringRequestCard` | Subject, status badge, creation date, response count chip | Stagger slide-up entry; response count: counter increment animation on new response; **Hero** on card tap for manage page transition |
| `CreateRequestFAB` | Disabled at 3 open with tooltip | Disabled: opacity 0.5 + rotation lock animation (shake when tapped disabled, 300 ms); enabled: standard FAB entry + Rive shimmer |
| `EmptyStateWidget` | Per tab | **Lottie** per tab state: open→empty clipboard, fulfilled→trophy, expired→hourglass |

---

### `CreateTutoringRequestPage`
**Route:** `/requests/create`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `SubjectTextField` | Required | Standard focus animation; entry stagger 0 ms |
| `DescriptionTextArea` | Required, 1000-char with `CharacterCounter` | Height expand on focus (250 ms); char counter approach-limit color transition |
| `DayOfWeekMultiSelect` | Optional preferred days | Selected days: scale 1.0→1.1 + fill (200 ms); unselected: opacity 0.5 |
| `TimeRangePicker` | Optional preferred time window | Drum-roll 3D pickers (CupertinoStyle); duration bar animates width |
| `MaxRequestWarningBanner` | "You have 2/3 open requests" warning | Slide-down + orange pulse border; at 2/3: appears automatically with attention-shake (400 ms, 1× only) |
| `SubmitButton` | Disabled while form invalid | Same disabled/enabled animated opacity + elevation |

---

### `TutoringRequestManagePage`
**Route:** `/requests/:requestId/manage`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `RequestHeader` | Subject, status badge, expiry date | Slide-down + fade; expiry countdown pulse when < 24 h |
| `DescriptionSection` | Full description | Fade-in delay 200 ms |
| `PreferredTimingSection` | Days + time range | Day chips stagger-appear |
| `RespondingTutorsList` | Tutors who sent an `AppointmentRequest` in response | `AnimatedList` — new tutor response slides in from top (300 ms, `easeOut`); notification dot pulses on new entry |
| `RespondingTutorCard` | Avatar, name, rating, subjects, "View Profile" | 3D tilt on press; stagger slide-up on list load |
| `CloseRequestButton` | Manual close with `ConfirmationDialog` | Tap: red background bleed animation (200 ms); dialog: destructive scale + backdrop blur |

---

## 8. Appointment Requests

---

### `IncomingAppointmentRequestsPage`
**Route:** `/appointment-requests/incoming`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `StatusTabBar` | Pending / Accepted / Rejected / Expired | Tab indicator slide; pending tab: badge pulse on new items |
| `IncomingRequestCard` | Sender avatar, subject, proposed time, `ExpiryCountdown` | Stagger slide-up entry; new request: brief yellow highlight flash (500 ms) on first render; **Hero** on avatar |
| `EmptyStateWidget` | Per tab | **Lottie** per state: pending→hourglass, accepted→handshake, rejected→x-mark, expired→clock |

---

### `SentAppointmentRequestsPage`
**Route:** `/appointment-requests/sent`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `StatusTabBar` | Pending / Accepted / Rejected / Expired | Same tab animations; accepted tab: brief green glow on status update |
| `SentRequestCard` | Receiver avatar, subject, proposed time, status badge, Cancel button | Stagger slide-up; status badge change: cross-fade + scale-in (300 ms, `easeOutBack`); **Hero** on avatar |
| `EmptyStateWidget` | Per tab | Same Lottie states as IncomingRequestsPage |

---

### `CreateAppointmentRequestPage`
**Route:** `/appointment-requests/create`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `TargetUserCard` | Pre-filled read-only tutor/seeker card | **Hero** from source; card has 3D floating depth shadow (4 dp `BoxShadow`); non-interactive shimmer on enter (300 ms, once) |
| `SubjectTextField` | Pre-filled if from tutoring request | If pre-filled: value types in character-by-character animation (200 ms total) |
| `NoteTextArea` | Optional, 500-char with `CharacterCounter` | Height expand; char counter |
| `DatePickerField` | Future dates only | Calendar sheet slides up (300 ms); selected date scales 1.0→1.15 (200 ms) |
| `TimeRangePicker` | Start + end; min 30 min enforced | Drum-roll 3D pickers; duration bar width animation |
| `DurationDisplay` | Computed "Xh Ym" label | Flip-up digit transition on every change (100 ms) |
| `EstimatedCostDisplay` | `hourlyRate × duration` | Counter animation on every duration change (300 ms, `easeOut`); color highlight on change (200 ms yellow flash) |
| `TutorAvailabilityHintGrid` | Read-only weekly slots shown as hint | Same grid stagger-reveal; hint cells have 50% opacity with blur overlay |
| `ConflictWarningBanner` | Appears if proposed time overlaps | Slide-down + red shake (identical to ErrorBanner); pulses while conflict persists |
| `SubmitButton` | Disabled while conflict or invalid | Same disabled/enabled animated opacity |

---

### `AppointmentRequestDetailPage`
**Route:** `/appointment-requests/:requestId`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `RequestStatusHeader` | Status badge + `ExpiryCountdown` | Status badge scale-in `easeOutBack`; badge color transitions on status change (300 ms cross-fade) |
| `ParticipantsRow` | Tutor card + Seeker card side by side | Cards slide in from opposite sides (left/right, 300 ms, `easeOut`, stagger 100 ms); **Hero** on both avatars |
| `SessionInfoCard` | Subject, date, start–end time, duration | Card slide-up (delay 200 ms); **3D tilt** on press ±4° |
| `EstimatedCostDisplay` | Simulated cost | Same counter animation |
| `NoteSection` | Optional note text | Fade-in (delay 350 ms) |
| `AcceptButton` | Receiver + pending only | **Rive** button: idle state → tap: green burst + scale 1.0→1.05 + checkmark morph |
| `RejectButton` | Receiver + pending only | **Rive** button: tap: red shake + X morph |
| `CancelButton` | Sender + pending only | Tap: scale + confirmation dialog |
| `StatusTimelineWidget` | Sent → Pending → Accepted/Rejected | Steps reveal left-to-right (stagger 150 ms each, 300 ms `easeOut`); current step: pulsing ring (1.5 s loop); completed step: checkmark draw animation (400 ms `CustomPainter` path) |

---

## 9. Appointments & Schedule

---

### `SchedulePage`
**Route:** `/schedule`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `SegmentedControl` | Calendar / List toggle | Indicator slide (250 ms, `easeInOut`); content cross-fade (200 ms) |
| `AppCalendarWidget` | Monthly grid; colored dots on days with appointments | **Month transition**: `PageView` with `SlideTransition` + subtle `Matrix4.rotationX` 3D page-turn (5°, 400 ms); day selection: ripple + scale 1.0→1.15 (150 ms); dots: stagger-pop-in `ScaleTransition` (30 ms each, `easeOutBack`); today cell: pulsing accent ring (3 s loop) |
| `DayAppointmentsList` | Tapping a day shows list below calendar | `AnimatedSize` height expand (300 ms, `easeInOut`); appointments stagger-slide-in (40 ms each) |
| `FilterTabBar` | Upcoming / Past / All | Tab indicator slide; tab switch: content cross-fade (200 ms) |
| `AppointmentCardList` | Scrollable list | Stagger slide-up entry |
| `AppointmentCard` | Subject, other party avatar + name, date/time, status badge | 3D tilt on press ±5°; **Hero** on other-party avatar; status badge color matches `AppointmentStatus`; upcoming: subtle green left border animated-in (300 ms) |
| `LoadingShimmerList` | Skeleton during fetch | Same Shimmer sweep |
| `EmptyStateWidget` | Per tab/view | **Lottie** empty-calendar (calendar with empty days, soft idle loop) |

---

### `AppointmentDetailPage`
**Route:** `/appointments/:appointmentId`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `AppointmentStatusHeader` | Subject, status badge | Slide-down + fade; badge scale-in `easeOutBack` |
| `ParticipantsRow` | Tutor + Seeker cards | Same opposite-sides slide-in as AppointmentRequestDetailPage |
| `SessionTimeCard` | Date, start, end, duration | Slide-up (delay 200 ms); **3D tilt** on press; duration computed counter animation on enter |
| `PaymentSummaryCard` | Simulated amount, currency, status | Card slide-up (delay 300 ms); amount counter animation; status badge color-matches `PaymentStatus` |
| `StatusTimelineWidget` | Request → Confirmed → Completed/Cancelled | Same step-reveal with checkmark draw |
| `CancelButton` | Shown if > 4 h before session | Visible: slide-up (300 ms); disabled: opacity 0.4 + tooltip fade-in on press |
| `CancellationBlockedBanner` | Shown when within the 4-hour window | Slide-down + amber color; lock icon shakes (300 ms, 1×) on banner appear |
| `LeaveReviewButton` | Seeker only, after `completed`, if review not yet written | Entrance: `ScaleTransition` 0→1 with `easeOutBack` (400 ms) + shimmer sweep (500 ms, once); star icons pulse in sequence (stagger 100 ms) to draw attention |
| `GoToConfirmationButton` | Shown after `endAt` while outcome is unset | Pulsing orange accent glow (1.5 s loop) to indicate urgency; **Rive** idle animation |

---

### `CancelAppointmentPage`
**Route:** `/appointments/:appointmentId/cancel`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `CancellationWarningCard` | Explains cancellation rules + trust impact | **Lottie** warning illustration (animated warning icon, plays once on enter); card has red-gradient top border animated-in (500 ms) |
| `ReasonTextArea` | Optional, 300-char with `CharacterCounter` | Standard height-expand + char counter |
| `ConfirmCancelButton` | Destructive red button | Idle: subtle red glow pulse (2 s loop); tap: scale 0.96 + red wave ripple (200 ms); after confirm: button morphs to spinner (cross-fade 200 ms) |
| `GoBackButton` | Secondary action | Standard scale press (0.97, 80 ms) |

---

## 10. Session Confirmation

---

### `SessionConfirmationPage`
**Route:** `/appointments/:appointmentId/confirm`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `SessionSummaryCard` | Subject, tutor, seeker, date/time | **3D card perspective**: card enters with `Matrix4.rotationX` -15°→0° + scale 0.95→1.0 (600 ms, `easeOutCubic`); floating `BoxShadow` depth layers |
| `ConfirmationWindowCountdown` | Live timer showing hours left in 24-hour window | Flip-clock digit animation (100 ms per tick, `Curves.easeIn`); ring progress `CustomPainter` (arc sweeps 0→full on page load 800 ms, then live); < 4 h: timer turns orange; < 1 h: turns red + pulse glow (1.5 s loop) |
| `OtherPartyStatusBadge` | "Partner has confirmed" / "Waiting for partner" | Cross-fade between states (300 ms); confirmed: green checkmark draw (400 ms); waiting: pulsing dots (1.2 s, repeat) |
| `ConfirmAttendanceButton` | Primary CTA | **Rive** interactive: idle → hover shimmer → tap: checkmark draw + green burst; on success: morphs to large checkmark (600 ms) |
| `SessionDidNotHappenButton` | Secondary destructive CTA | Tap: red color + X icon appear (200 ms); confirmation sub-dialog: scale-in (150 ms) |
| `OutcomeBadge` | Read-only outcome chip after resolution | Scale-in `easeOutBack` (400 ms); color matches `SessionOutcome`; **Lottie** micro-icon per outcome (checkmark/absent/dispute) |
| `OutcomeExplanationCard` | Explains payment result tied to outcome | Slide-up (delay 400 ms, 400 ms); card has colored left accent border matching outcome color, animated-in width (300 ms) |

---

## 11. Session History

---

### `HistoryPage`
**Route:** `/history`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `HistoryTabBar` | Sessions / Appointments / People | Tab indicator slide; tab content cross-fade (200 ms) |
| `SessionHistoryCard` | Subject, other party, date, outcome badge, payment result chip | Stagger slide-up; outcome badge scale-in; completed: subtle green shimmer on card bg (once, 600 ms); **Hero** on other-party avatar |
| `AppointmentCard` | All statuses including cancelled/expired | Same as SchedulePage AppointmentCard; cancelled: opacity 0.7 + strikethrough subject text cross-fade |
| `InteractedUsersGrid` | 2-column grid of `UserAvatarNameCard` | Grid cells stagger-scale-in (30 ms each, `easeOutBack`); **Hero** on each avatar |
| `UserAvatarNameCard` | Avatar, name, role badge | 3D tilt on press ±6°; avatar **Hero** tag; role badge color-coded |
| `EmptyStateWidget` | Per tab | **Lottie** per tab: sessions→empty timeline, appointments→blank calendar, people→empty contact book |

---

### `SessionDetailPage`
**Route:** `/history/sessions/:appointmentId`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `SessionSummaryCard` | Read-only session info | **Hero** from HistoryCard; same 3D perspective card entry (600 ms) |
| `ParticipantsRow` | Tutor + Seeker cards | Same opposite-sides slide-in; **Hero** on both avatars |
| `OutcomeBadge` | Final outcome | Scale-in with Lottie micro-icon |
| `PaymentResultCard` | Amount + released/refunded status | Slide-up; amount counter animation; released: green check; refunded: blue arrow |
| `ReviewCard` | Review written for this session | Slide-up (delay 350 ms); stars fill stagger (80 ms each) |
| `WriteReviewButton` | → `WriteReviewPage` | Same shimmer CTA as LeaveReviewButton; star pulse sequence draw attention |

---

## 12. Reviews & Ratings

---

### `WriteReviewPage`
**Route:** `/reviews/write/:appointmentId`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `SessionReferenceCard` | Read-only context: subject, tutor, date | **Hero** from source; 3D perspective card (same as SessionSummaryCard) |
| `StarRatingSelector` | Interactive 1–5 star tap selector | Stars scale 1.0→1.3→1.0 on each tap (150 ms `easeOutBack`); selected stars: fill sweep `CustomPainter` (200 ms per star, stagger 40 ms); hover/drag: real-time fill with sub-integer support; sparkle particle burst on 5-star select |
| `ReviewCommentTextArea` | Optional, 500-char with `CharacterCounter` | Height expand; char counter color shift |
| `SubmitReviewButton` | Disabled until rating selected | Same disabled/enabled animation; on submit: **Lottie** star-burst (600 ms, once) |
| `SuccessStateWidget` | Shown after successful submission | **Lottie** review-submitted (large animated star fills screen, shrinks to checkmark, 1200 ms); confetti `CustomPainter` particle system (2 s, gravity-fall) |

---

### `MyReviewsPage` *(tutor view)*
**Route:** `/reviews/received`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `AverageRatingDisplay` | Large rating number + stars + review count | Number: `TweenAnimationBuilder<double>` 0→value (800 ms, `easeOut`); stars: fill stagger; review count: counter animation; all wrap in `ScaleTransition` 0.8→1.0 on entry |
| `RatingDistributionBar` | 5→1 horizontal bar chart | Bars animate width left-to-right (stagger 80 ms, 400 ms `easeOut`); bars have 3D depth gradient; tooltip appears on tap per bar |
| `ReviewCardList` | Paginated list | Stagger slide-up (40 ms each); pagination: new cards slide-in below |
| `ReviewCard` | Seeker avatar, rating stars, comment, date | 3D tilt on press; **Hero** on seeker avatar; stars display-only |
| `EmptyStateWidget` | "No reviews yet" | **Lottie** empty-stars (outline stars floating, gentle idle loop) |

---

### `ReviewsGivenPage` *(seeker view)*
**Route:** `/reviews/given`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `ReviewCardList` | Paginated list | Same stagger-slide entry |
| `ReviewCard` | Tutor avatar, subject, rating stars, comment, date | Same as MyReviewsPage ReviewCard; **Hero** on tutor avatar |
| `EmptyStateWidget` | "You haven't reviewed any sessions yet" | **Lottie** empty-review (blank notepad with pen, idle loop) |

---

## 13. Payments (Simulated)

---

### `PaymentHistoryPage`
**Route:** `/payments`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `StatusTabBar` | All / Released / Refunded / Held | Tab slide indicator; content cross-fade |
| `PaymentCardList` | Paginated list | Stagger slide-up entry |
| `PaymentCard` | Subject, other party, amount + currency, status badge, session date | 3D tilt on press; amount: static display; released: green left border; refunded: blue; held: amber; `ScaleTransition` on status badge |
| `EmptyStateWidget` | Per tab | **Lottie** per state: all-empty→empty wallet, released→money-out, refunded→money-return, held→locked-coin |

---

### `PaymentDetailPage`
**Route:** `/payments/:paymentId`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `PaymentAmountHeader` | Large formatted amount + currency | Counter animation 0→amount (800 ms, `easeOut`); **3D perspective** amount text with subtle shadow depth; color matches payment status |
| `PaymentStatusTimeline` | Held → Released / Refunded step indicator | Same step-reveal as StatusTimelineWidget; current step pulses; completed: checkmark draw |
| `SessionReferenceCard` | Subject, date, participants | Slide-up (delay 200 ms); 3D tilt on press |
| `ParticipantsRow` | Tutor + Seeker | Same opposite-sides slide-in; **Hero** on both avatars |
| `ViewSessionButton` | → `SessionDetailPage` | Standard tap scale + navigation |

---

## 14. Notifications

---

### `NotificationsPage`
**Route:** `/notifications`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `MarkAllReadButton` | In app bar actions | Tap: all unread dots fade-out simultaneously (300 ms, stagger 20 ms each); icon: envelope-open **Lottie** micro-animation (400 ms) |
| `NotificationGroupHeader` | "Today" / "Earlier" section dividers | Sticky header slide-up behind `SliverAppBar`; fade-in on scroll-into-view |
| `NotificationItemList` | Full list | `AnimatedList` — new items slide-in from top (300 ms, `easeOut`); unread items have persistent left accent border |
| `NotificationItem` | Icon (by `NotificationType`), title, body, timestamp, unread dot | Unread dot: pulse glow (1.5 s loop, 5 dp radius oscillation); icon: **Lottie** micro-animation per type (on first appear only); tap: background color flash (200 ms) then mark-read dot fade-out; **Rive** swipe-to-delete with red background reveal |
| `EmptyStateWidget` | "You're all caught up" | **Lottie** all-done (checkmark with stars celebration, plays once then idle) |

---

## 15. Reports & Safety

---

### `ReportUserPage`
**Route:** `/report/:userId`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `ReportedUserCard` | Avatar, name — read-only context | Slide-down + fade (non-interactive; red border glow signals context); **Hero** on avatar |
| `ReasonRadioGroup` | One radio per `ReportReason` value | Selected radio: scale + color fill (200 ms); list stagger-fade-in entry (30 ms each) |
| `ReportDescriptionTextArea` | Required, 1000-char with `CharacterCounter` | Height expand; char counter; approach-limit: border pulse red (300 ms) |
| `LinkedAppointmentDropdown` | Optional — shared appointments only | Slide-down stagger on open |
| `SubmitReportButton` | Disabled while form invalid | Same disabled/enabled animation; red destructive color |
| `SuccessStateWidget` | Confirmation shown after submission | **Lottie** report-submitted (shield with checkmark, 1000 ms, plays once); message fades in below |
| `RateLimitWarningBanner` | Shown if reporter is approaching 3-report limit | Slide-down + amber; at 2/3: auto-appears with attention-shake once |

---

### `MyReportsPage`
**Route:** `/reports/my`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `ReportCardList` | All submitted reports | Stagger slide-up entry |
| `ReportCard` | Reported user avatar + name, reason label, status badge, submission date | 3D tilt on press; **Hero** on avatar; status badge cross-fades on update |
| `StatusBadge` | Open / Under Review / Resolved / Dismissed | Scale-in `easeOutBack`; color map: open→amber pulse, under-review→blue pulse, resolved→green static, dismissed→grey static |
| `EmptyStateWidget` | "No reports submitted" | **Lottie** empty-shield (shield with sparkles, idle loop) |

---

## 16. Settings

---

### `SettingsPage`
**Route:** `/settings`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `SettingsSectionHeader` | Section grouping labels | Fade-in stagger (20 ms each section, 200 ms) |
| `SettingsNavTile` | Arrow tile → sub-pages | Tap: `InkWell` ripple + chevron translate-right +4 dp (150 ms); page push: shared-axis horizontal transition |
| `LogoutListTile` | With `DestructiveConfirmationDialog` | Tap: red text flash (200 ms); dialog: scale + backdrop blur (200 ms) |

---

### `AccountSettingsPage`
**Route:** `/settings/account`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `ChangePasswordTile` | Triggers Firebase email reset flow | Tap: email-sent **Lottie** micro (envelope icon, 400 ms) after Firebase call |
| `DeleteAccountTile` | Opens `DestructiveConfirmationDialog` with typed confirmation | Tile turns red on tap (200 ms); dialog appears with scale + backdrop blur |
| `ConfirmationDialog` | Reusable double-confirm modal | Scale 0.85→1.0 + fade-in (200 ms, `easeOutBack`); confirm input field shakes if text doesn't match (400 ms) |

---

### `NotificationPreferencesPage`
**Route:** `/settings/notifications`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `NotificationGroupSwitch` | One `SwitchListTile` per `NotificationType` group | **Rive** switch (same as AcceptingRequestsSwitch); row opacity 0.5 when off (200 ms `AnimatedOpacity`) |

---

### `PrivacySafetyPage`
**Route:** `/settings/privacy`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `SafetyGuidelinesCard` | Formatted community rules text | Expand/collapse `SizeTransition` (300 ms); scroll-fade bottom mask |
| `ExternalLinkTile` | PPU student code of conduct URL | Tap: external-link icon rotates +45° (200 ms); opens in-app browser with slide-up transition |
| `NavigationTile` | → `MyReportsPage` | Standard chevron nav tile animation |

---

### `AboutPage`
**Route:** `/settings/about`
| Component | Description | Animations & 3D |
|-----------|-------------|-----------------|
| `AppVersionTile` | App version + build number | On long-press: **Lottie** easter-egg micro-animation (logo spins, 600 ms) |
| `ExternalLinkTile` | Privacy Policy | Same external-link tile animation |
| `ExternalLinkTile` | Terms of Service | Same |

---

---

# Shared Components

> Location: `lib/core/widgets/`
> Imported by any feature; no feature-specific logic inside.

---

## Layout & Navigation

| Component | Props / Notes | Animations & 3D |
|-----------|---------------|-----------------|
| `AppScaffold` | Wraps `Scaffold`; accepts `appBar`, `body`, `fab`, `bottomNav`; applies background color from theme | Page enter: body fades in (200 ms); smooth `AnimatedSwitcher` for body content changes |
| `MainBottomNavBar` | Role-aware tabs; accepts `currentIndex`, `onTap`; shows Requests/Schedule/History/Profile always; Home tab label changes by role | Active tab icon: scale 1.0→1.2 + color fill (200 ms, `easeOut`); inactive: opacity 0.6 (200 ms); tab change: `SharedAxisTransition` horizontal (300 ms) for page content; FAB morph between tabs if FABs differ (cross-fade 200 ms) |
| `AppBarWithActions` | Standard app bar; accepts `title`, `actions`; always shows `NotificationBell` | Title: fade-in on page settle (150 ms); collapsing variant: `SliverAppBar` with parallax background |
| `SectionHeader` | Section divider with left-aligned title and optional trailing widget | Fade-in + slide-left (200 ms) on scroll-into-view via `IntersectionObserver` equivalent |
| `PageLoadingIndicator` | Centered `CircularProgressIndicator` with optional label | Same 3-ring concentric loader as SplashPage; fade-in (150 ms), fade-out (150 ms) on done |

---

## Form Components

| Component | Props / Notes | Animations & 3D |
|-----------|---------------|-----------------|
| `AppTextField` | Base text field; `label`, `hint`, `controller`, `validator`, `keyboardType`, `enabled`; themed consistently | Focus: border width 1→2 dp, color transition accent (200 ms `easeOut`); label float `FloatingLabelAnimation` (Material); error: border turns red + helper text slide-down (200 ms); disabled: opacity 0.5 (150 ms) |
| `EmailTextField` | Extends `AppTextField`; email keyboard, lowercase input, `@` prefix icon | @ icon: scale-in on focus (200 ms); valid email: trailing check icon fade-in (200 ms, green) |
| `PasswordTextField` | Extends `AppTextField`; obscure text with show/hide `IconButton` in suffix | Eye icon: `RotationTransition` 0→π/2 on toggle (200 ms); text scramble animation 200 ms on toggle |
| `FullNameTextField` | Extends `AppTextField`; text capitalize words | Standard; capitalization hint icon pulse on first focus (1×, 300 ms) |
| `PhoneTextField` | Extends `AppTextField`; phone keyboard, `+` prefix icon | + icon scale-in on focus (200 ms) |
| `TextAreaField` | Multiline `AppTextField`; `maxLines`, `maxLength`, shows `CharacterCounter` | `AnimatedContainer` height: expands on focus from 1-line to maxLines height (300 ms, `easeOut`) |
| `CharacterCounter` | `"X / max"` text; turns red when > 90% used | `AnimatedDefaultTextStyle` color cross-fade: neutral→orange at 80% → red at 90% (300 ms each); scale 1.0→1.05 at each threshold |
| `PasswordStrengthBar` | Animated bar: red / orange / green based on score | `TweenAnimationBuilder` width 0→score% (400 ms, `easeOut`); color cross-fade between levels (300 ms); **3D depth**: inner glow `BoxShadow` grows with strength; strength label fades-in (200 ms) |
| `DropdownSelector<T>` | Generic styled dropdown; `items`, `value`, `onChanged`, `labelBuilder` | Open: items stagger-fade-in + slide from -10 dp (30 ms each, max 200 ms); close: items fade-out (150 ms); selected indicator slides to new item (200 ms, `easeInOut`) |
| `DatePickerField` | Interactive field opening `showDatePicker`; rejects past dates when `futureOnly: true` | Field tap: ripple + chevron rotate 90° (200 ms); sheet: slide-up (300 ms); selected date: scale 1.15 + fill (150 ms, `easeOutBack`); past dates: opacity 0.3 |
| `TimePickerField` | Interactive field opening `showTimePicker` | **3D drum-roll**: CupertinoStyle picker with perspective (`Matrix4.perspective`) on each drum column; selected row: scale 1.05 + full opacity; adjacent rows: perspective shrink + 0.7 opacity |
| `TimeRangePicker` | Two `TimePickerField` in a row; enforces start < end, min duration | Duration bar between pickers: width `TweenAnimationBuilder` (300 ms); invalid range: both pickers border-flash red simultaneously (400 ms, shake) |
| `DurationDisplay` | Read-only label computing `end - start` in "Xh Ym" format | Flip-up digit animation per digit change (100 ms, `CurveTween` easeIn); color: neutral → green when ≥ 30 min (300 ms cross-fade) |
| `DayOfWeekSelector` | Row of 7 toggle chips Mon–Sun; single or multi select | Selected chip: scale 1.0→1.12 + fill + slight elevation (200 ms, `easeOutBack`); deselect: reverse; multi-select: selection-ripple between toggled days |

---

## User & Profile

| Component | Props / Notes | Animations & 3D |
|-----------|---------------|-----------------|
| `UserAvatar` | `avatarUrl`, `name` (fallback initials), `size` (xs/sm/md/lg); circular | **Hero** tag for profile transitions; image load: `FadeInImage` crossfade (300 ms); fallback initials: scale-in (200 ms, `easeOutBack`); outer ring glow (xs: none, sm: 1 dp, md: 2 dp, lg: 3 dp gradient `BoxShadow`) |
| `UserCard` | `UserAvatar` + name + `RoleBadge`; compact horizontal row | Tap: scale 0.97 + elevation lift (100 ms); role badge scale-in stagger |
| `TutorCard` | Full listing card: avatar, name, major, `RatingStars`, subject chips, hourly rate | **3D tilt**: `GestureDetector` → `Transform.perspective(1500)` rotate X/Y ±6° (100 ms `easeOut`, return 200 ms); elevation 2→8 dp (150 ms); **Hero** on avatar; stagger entry in lists (40 ms offset) |
| `TutorProfileCard` | Rich card for `PublicProfilePage`: all tutor fields + bio | **3D floating card**: `BoxShadow` multi-layer depth (4 dp + 1 dp ambient); parallax: `Transform.translate` +3 dp on subtle scroll listener; card border gradient animates on mount (500 ms) |
| `RoleBadge` | Colored chip: Seeker (blue) / Tutor (green) / Both (purple) | Scale-in `easeOutBack` (200 ms); color: Seeker=#2196F3, Tutor=#4CAF50, Both=#9C27B0 with 15% opacity fill |
| `RatingStars` | Display-only; `value` 0.0–5.0, `size`, half-star support | `CustomPainter` path fill-sweep per star (stagger 60 ms each, 200 ms `easeOut`); half-star clip on fractional value; display-only golden fill |
| `StarRatingSelector` | Interactive tap selector; emits `int` 1–5 | Each star: tap scale 1.0→1.4→1.0 (150 ms, `easeOutBack`); fill sweeps left-to-right per star; drag: real-time rating update; 5★: sparkle particle burst (`CustomPainter`, 1 s) |
| `SubjectChipList` | Horizontal `Wrap` of read-only chips | Chips stagger-fade-in (30 ms each) on mount; subtle bounce on first appear |
| `SubjectMultiSelectInput` | Chip input with add/remove; free-text add with Enter | Add: `ScaleTransition` 0→1 + fade (200 ms, `easeOutBack`); remove: scale + fade out (150 ms); `AnimatedSize` container reflows |
| `AvatarUploadWidget` | Interactive avatar circle; opens bottom sheet for camera/gallery; shows crop dialog | **3D flip** on photo accept: `Matrix4.rotationY` 0→π (600 ms, `easeInOut`); upload progress: arc `CustomPainter` (0→360° animated); compress step: pulsing opacity (0.7↔1.0, 400 ms loop) |
| `ProfileAvatarHeader` | Large `UserAvatar` + name + `RoleBadge` centered at page top | **Hero** expansion; parallax scroll: avatar translates -0.5× scroll offset; name + badge stagger-slide-up (100 ms delay, 300 ms); collapsed `SliverAppBar` state: avatar shrinks to appbar height (smooth `SliverPersistentHeader` delegate) |

---

## Appointments & Scheduling

| Component | Props / Notes | Animations & 3D |
|-----------|---------------|-----------------|
| `AppointmentCard` | Subject, other party `UserCard`, date/time, `StatusBadge`; interactive | **3D tilt** ±5°; `BoxShadow` elevation 2→6 dp on press; status-colored left border animated-in width (300 ms); **Hero** on other-party avatar |
| `SessionTimeCard` | Date row + start–end time + computed duration | Slide-up on mount; **3D perspective tilt** ±4° on press; time fields: flip-up on any edit (100 ms) |
| `ParticipantsRow` | Tutor `UserCard` + "↔" icon + Seeker `UserCard` | Cards enter from opposite sides (left/right, 300 ms, `easeOut`, stagger 100 ms); "↔" icon: scale-in center (delay 200 ms, 200 ms, `easeOutBack`) |
| `WeeklyAvailabilityGrid` | 7-column Mon–Sun grid; cells show slot times; `editable` mode adds tap-to-edit | Column-by-column stagger reveal (40 ms each, 200 ms); slot cells: fill-in top-to-bottom (300 ms); editable tap-cell: scale 0.95 + ripple (150 ms); 3D depth: column headers have top shadow |
| `SlotCard` | Day label + time range + active `Switch` + edit/delete `IconButton`s | `AnimatedList` slide-in/out; `Rive` switch; swipe-to-reveal action icons with `Dismissible` red background |
| `AppCalendarWidget` | Monthly calendar built on `table_calendar` (or custom); dots colored by status | **3D page-flip month**: `Matrix4.rotationX` ±5° during swipe (400 ms, `easeOut`); day cells: `InkWell` ripple + scale on tap; dot appear: stagger `ScaleTransition` (20 ms each); today: pulsing accent ring; weekend: subtle background tint |
| `StatusTimelineWidget` | Horizontal step indicator with labels and icons | Steps slide-in left-to-right (stagger 150 ms, 300 ms `easeOut`); completed: checkmark `CustomPainter` path draw (400 ms); current step: pulsing ring (1.5 s loop, `Curves.easeInOut`); connector line: width fill animation (500 ms) |

---

## Requests

| Component | Props / Notes | Animations & 3D |
|-----------|---------------|-----------------|
| `AppointmentRequestCard` | Compact request card with `ExpiryCountdown` | Same 3D tilt + elevation as `AppointmentCard`; countdown pulse when < 1 h |
| `TutoringRequestCard` | Seeker info + subject + description snippet + day chips | Same 3D tilt; new-request badge: scale-in + pulse glow (1.5 s loop); **Hero** on seeker avatar |
| `IncomingRequestCard` | Extends `AppointmentRequestCard`; shows Accept/Reject inline buttons | Accept button: **Rive** green confirm; Reject: **Rive** red X; both: scale press + state change `AnimatedSwitcher` |
| `SentRequestCard` | Extends `AppointmentRequestCard`; shows Cancel inline button | Cancel button: tap confirmation micro-animation (scale + color, 200 ms) |
| `ExpiryCountdown` | Wraps `CountdownTimer`; turns red < 1 h; shows "Expired" when done | Inherited from `CountdownTimer`; color cross-fade neutral→orange at 2 h, orange→red at 1 h (300 ms each); expired: `AnimatedSwitcher` cross-fade to "Expired" label (300 ms) |
| `CountdownTimer` | Live ticking `HH:MM:SS` or "Xh Ym" display; fires `onExpired` callback | Flip-clock digit animation (each digit flips independently, 80 ms, `Curves.easeIn`); pulse glow on digit change |
| `OpenRequestCountBadge` | "X / 3" chip; red when at limit | Color cross-fade neutral→red at limit (300 ms); count change: scale 1.0→1.2→1.0 (150 ms, `easeOutBack`) + digit flip |

---

## Reviews & Ratings

| Component | Props / Notes | Animations & 3D |
|-----------|---------------|-----------------|
| `ReviewCard` | Reviewer `UserAvatar` + name + `RatingStars` + comment + date | 3D tilt ±4° on press; **Hero** on avatar; stars fill stagger on mount |
| `RatingDistributionBar` | Five rows (5★→1★) each a labeled linear progress bar | Bars animate width 0→value (stagger 80 ms each, 400 ms `easeOut`); **3D depth**: bars have inner glow shadow; tap: tooltip `ScaleTransition` appear (200 ms, `easeOutBack`) |
| `AverageRatingDisplay` | Large `double` + `RatingStars` + "(N reviews)" | Number `TweenAnimationBuilder<double>` 0→value (800 ms, `easeOut`); stars fill on entry; review count counter animation; all wrap `ScaleTransition` 0.8→1.0 |

---

## Payments

| Component | Props / Notes | Animations & 3D |
|-----------|---------------|-----------------|
| `PaymentCard` | Subject, other party, `AmountDisplay`, `StatusBadge`, date | Same 3D tilt; status left-border color animation; **Hero** on other-party avatar |
| `PaymentStatusTimeline` | Three-step indicator: Held → Released / Refunded | Same `StatusTimelineWidget` animations; released step: green sparkle (Lottie micro); refunded: blue arrow animation |
| `AmountDisplay` | Formatted `"ILS 50.00"` with currency prefix | Currency label fades in first (100 ms), then amount slides in from right (200 ms); 3D depth: subtle text shadow (1 dp offset, 20% opacity) |
| `EstimatedCostDisplay` | Computed from rate × duration; labeled "Estimated Cost" | `TweenAnimationBuilder<double>` counter (300 ms, `easeOut`) on every change; yellow highlight flash on change (200 ms) |
| `PaymentSummaryCard` | Compact card: amount + status badge used in `AppointmentDetailPage` | Slide-up mount; amount counter; badge scale-in |

---

## Feedback & State

| Component | Props / Notes | Animations & 3D |
|-----------|---------------|-----------------|
| `EmptyStateWidget` | SVG illustration + `message` + optional `actionLabel` + `onAction` | **Lottie** illustration (looping idle, context-specific); illustration fades in first (300 ms), message slides up (delay 200 ms, 300 ms), action button scales in (delay 400 ms, 300 ms `easeOutBack`) |
| `ErrorStateWidget` | Error illustration + `message` + "Retry" button | **Lottie** error illustration (broken connection / error face, plays once then idle); message + retry stagger in; Retry button: scale press + spinner cross-fade (200 ms) |
| `LoadingShimmerList` | Animated shimmer cards matching list item shape; `itemCount` | `Shimmer` package: sweep left→right (1200 ms, `linear`, `RotationTransition` for circular elements); cards fade-out when real content arrives (300 ms cross-fade) |
| `SuccessStateWidget` | Checkmark illustration + `message` + optional CTA | **Lottie** success (checkmark draw + glow burst, 800 ms, plays once); confetti `CustomPainter` if celebratory context (2 s gravity-fall); message + CTA stagger-fade after Lottie frame 30 |
| `ErrorBanner` | Red inline strip at top of form; `message`; dismissible | Slide-down from -100% (300 ms, `easeOut`); shake 3× horizontal (400 ms, `Curves.elasticOut`); dismiss: slide-up + fade (200 ms); left-border accent pulse while visible |
| `InfoBanner` | Yellow inline strip; `message`; dismissible | Same slide-down (no shake); amber left-border; dismiss: slide-up + fade |
| `OverlapWarningBanner` | Orange inline strip for scheduling conflicts | Same slide-down + 1× shake; orange pulse border (600 ms loop while conflict active) |
| `CancellationBlockedBanner` | Explains the 4-hour cancellation rule | Slide-down; lock icon shakes (300 ms, 1×) on appear; amber color with gradient background |
| `MaxRequestWarningBanner` | Shows remaining request slots | At 2/3: attention-shake on first appear (1×); color: neutral→orange→red as slots fill |
| `RateLimitWarningBanner` | Warns reporter approaching submission limit | At 2/3 reports: attention-shake (1×); amber color |
| `ConfirmationDialog` | Modal with `title`, `message`, confirm/cancel buttons | `BackdropFilter` blur 0→6 (200 ms) + dialog `ScaleTransition` 0.85→1.0 + fade (200 ms, `easeOutBack`); dismiss: reverse |
| `DestructiveConfirmationDialog` | Extends `ConfirmationDialog`; confirm button is red | Same entry; confirm button: idle red glow pulse (1.5 s); tap: scale + deeper red flash |
| `UnsavedChangesDialog` | "Discard changes?" shown on back from dirty forms | Same scale + blur; discard button: `ColorFilterAnimation` to red (200 ms) |
| `LoadingOverlay` | Semi-transparent overlay with spinner; blocks interaction | `BackdropFilter(ImageFilter.blur)` 0→6 + `FadeTransition` 0→0.6 (200 ms); spinner `ScaleTransition` 0→1 (250 ms, `easeOutBack`); dismiss: blur fades out (200 ms) |
| `StatusBadge` | Colored chip for any status enum; color map per enum type | `ScaleTransition` 0→1 (`easeOutBack`, 200 ms) on mount; color cross-fade on status change (300 ms); pulse glow for active/pending states (1.5 s loop); color map: confirmed→green, pending→amber, rejected→red, expired→grey, cancelled→red-50 |
| `OutcomeBadge` | Colored chip for `SessionOutcome` values | Same scale-in; **Lottie** micro-icon per outcome: completed→checkmark, seekerAbsent/tutorAbsent→absent-person, bothAbsent→empty-chairs, disputed→warning-flag |

---

## Notifications

| Component | Props / Notes | Animations & 3D |
|-----------|---------------|-----------------|
| `NotificationBell` | Bell `IconButton` with unread count badge; in app bar | **Rive** bell: idle state (still); on new notification: ring animation (3 swings, 600 ms, spring curve); count badge: scale-in `easeOutBack` (200 ms) on count change; badge 0: scale-out (150 ms); tap: ripple + page push |
| `NotificationItem` | Leading icon (by `NotificationType`) + title + body + timestamp + unread dot | Unread dot: pulse glow (1.5 s loop, scale 1.0↔1.3, opacity 0.5↔1.0); **Lottie** icon micro per type (plays once on first appear): appointment→calendar-ring, confirmed→handshake, cancelled→x-calendar, payment→coin, review→star; mark-read: dot `ScaleTransition` 1→0 (200 ms) + background color flash |
| `NotificationGroupHeader` | Section label: "Today" / "Earlier" | Sticky scroll: `SliverPersistentHeader`; fade-in when section scrolls into view (200 ms) |

---

## Miscellaneous

| Component | Props / Notes | Animations & 3D |
|-----------|---------------|-----------------|
| `AppLogo` | SVG logo; `size` variants (sm / md / lg) | **Lottie** logo: sm=static SVG, md=scale-in (300 ms), lg=full reveal animation (1200 ms) + float loop; color: theme-aware (light/dark cross-fade on theme switch 300 ms) |
| `SearchBar` | `TextField` with search icon prefix and clear suffix | Focus: width expand + border accent (200 ms); search icon: scale-in (150 ms) on focus; clear button: `ScaleTransition` appear (150 ms) on text entry; results: fade-in (200 ms) |
| `FilterBar` | Horizontal `ListView` of filter `FilterChip`s | Active chip: scale 1.0→1.1 + fill color (200 ms, `easeOutBack`); scroll: fade-edge masks left/right; chip add/remove: `AnimatedList` scale + fade |
| `SortDropdown` | Compact dropdown anchored to a `TextButton` | Label cross-fade on selection (150 ms); dropdown: `ScaleTransition` + `FadeTransition` origin top-right (200 ms) |
| `ExternalLinkTile` | `ListTile` that launches URL via `url_launcher`; trailing open-in-new icon | Tap: icon rotates +45° (200 ms); `InkWell` ripple; in-app browser: slide-up (300 ms) |
| `SessionReferenceCard` | Read-only compact card: subject + date + other party | Slide-up on mount; **3D tilt** ±4° on press; **Hero** on other-party avatar |
| `ReasonRadioGroup` | Column of `RadioListTile` for enum values | Stagger-fade-in (30 ms each); selected: radio fill `CustomPainter` sweep (200 ms); row background color flash on select (150 ms) |
| `TutorAvailabilityHintGrid` | Read-only `WeeklyAvailabilityGrid` shown as hint in request form | Same grid stagger-reveal; hint opacity 0.6 + blur overlay 2 dp; slots fade in/out based on selected date |
| `AppVersionLabel` | `Text` reading version from `package_info_plus` | Fade-in last on page settle (delay 500 ms, 300 ms); long-press: **Lottie** easter-egg (logo spin 600 ms) |

---

---

# Validations

> Location: `lib/core/validators/`
> Each validator is a pure Dart class with static methods returning `String?` (null = valid).
> Used in both form `validator:` callbacks and in domain use cases.

---

## Auth Validators — `auth_validators.dart`

| Validator | Signature | Rules |
|-----------|-----------|-------|
| `EmailValidator.ppu` | `String? call(String? v)` | Non-null, valid format, must end with `@ppu.edu.ps` or `@student.ppu.edu.ps` |
| `EmailValidator.format` | `String? call(String? v)` | Non-null, RFC 5322 format (no domain restriction) |
| `PasswordValidator.strength` | `String? call(String? v)` | ≥ 8 chars, ≥ 1 uppercase, ≥ 1 digit, ≥ 1 special char |
| `PasswordValidator.match` | `String? call(String? v, String other)` | `v == other`; "Passwords do not match" |
| `NameValidator.required` | `String? call(String? v)` | Non-null, non-empty, ≤ 100 chars, no leading/trailing spaces |

---

## Academic Validators — `academic_validators.dart`

| Validator | Signature | Rules |
|-----------|-----------|-------|
| `GpaValidator.range` | `String? call(double? v)` | Nullable; if provided: 0.0 ≤ v ≤ 4.0 |
| `MajorValidator.required` | `String? call(String? v)` | Non-null, non-empty, ≤ 100 chars |

---

## Profile Validators — `profile_validators.dart`

| Validator | Signature | Rules |
|-----------|-----------|-------|
| `PhoneValidator.e164` | `String? call(String? v)` | Nullable; if provided: matches `^\+[1-9]\d{7,14}$` |
| `BioValidator.length` | `String? call(String? v)` | Nullable; if provided: ≤ 500 chars |
| `HourlyRateValidator.range` | `String? call(double? v)` | Non-null, ≥ 0.0, ≤ 10,000.0 |
| `SubjectsValidator.minOne` | `String? call(List<String> v)` | At least 1 non-empty subject |

---

## Scheduling Validators — `scheduling_validators.dart`

| Validator | Signature | Rules |
|-----------|-----------|-------|
| `TimeSlotValidator.order` | `String? call(AppTimeOfDay start, AppTimeOfDay end)` | `end` must be after `start` |
| `TimeSlotValidator.minDuration` | `String? call(AppTimeOfDay start, AppTimeOfDay end)` | Duration ≥ 30 minutes |
| `TimeSlotValidator.noOverlap` | `String? call(WeeklySlot incoming, List<WeeklySlot> existing)` | No time overlap on the same `dayOfWeek` |
| `AppointmentValidator.isFuture` | `String? call(DateTime proposed)` | `proposed` must be after `DateTime.now()` |
| `AppointmentValidator.minDuration` | `String? call(DateTime start, DateTime end)` | `end - start` ≥ 30 minutes |
| `AppointmentValidator.noConflict` | `String? call(DateTime s, DateTime e, List<Appointment> confirmed)` | `[s, e]` must not overlap any confirmed appointment for either party |
| `AppointmentValidator.canCancel` | `String? call(DateTime startAt)` | `startAt - DateTime.now()` > 4 hours |
| `AppointmentValidator.notExpired` | `String? call(DateTime expiresAt)` | `expiresAt` > `DateTime.now()` |

---

## Request Validators — `request_validators.dart`

| Validator | Signature | Rules |
|-----------|-----------|-------|
| `TutoringRequestValidator.maxOpen` | `String? call(int currentOpen)` | `currentOpen` < 3 |
| `TutoringRequestValidator.subject` | `String? call(String? v)` | Non-null, non-empty, ≤ 100 chars |
| `DescriptionValidator.required` | `String? call(String? v)` | Non-null, non-empty, ≤ 1,000 chars |
| `NoteValidator.optional` | `String? call(String? v)` | Nullable; if provided: ≤ 500 chars |
| `CancellationReasonValidator.optional` | `String? call(String? v)` | Nullable; if provided: ≤ 300 chars |

---

## Review Validators — `review_validators.dart`

| Validator | Signature | Rules |
|-----------|-----------|-------|
| `RatingValidator.range` | `String? call(int? v)` | Non-null, 1 ≤ v ≤ 5 |
| `ReviewCommentValidator.optional` | `String? call(String? v)` | Nullable; if provided: ≤ 500 chars |
| `ReviewEligibilityValidator.completed` | `String? call(SessionOutcome? outcome)` | `outcome == SessionOutcome.completed` |
| `ReviewEligibilityValidator.notDuplicate` | `String? call(bool alreadyReviewed)` | `alreadyReviewed == false` |

---

## Report Validators — `report_validators.dart`

| Validator | Signature | Rules |
|-----------|-----------|-------|
| `ReportDescriptionValidator.required` | `String? call(String? v)` | Non-null, non-empty, ≤ 1,000 chars |
| `SelfReportValidator.notSelf` | `String? call(String reporterId, String reportedId)` | `reporterId != reportedId` |
| `ReportRateLimitValidator.underLimit` | `String? call(int recentCount)` | `recentCount` < 3 (within 30-day window) |

---

---

# Mixins

> Location: `lib/core/mixins/`
> Applied to `State<T>` or BLoC/Cubit classes as needed.

---

## `FormValidationMixin`
**Applied to:** `State<T>` of any form page

```dart
mixin FormValidationMixin<T extends StatefulWidget> on State<T> {
  final formKey = GlobalKey<FormState>();
  bool _submitted = false;

  // Switches to per-field live validation only after first submit attempt
  bool get isLiveValidating => _submitted;

  bool validateForm() {
    setState(() => _submitted = true);
    return formKey.currentState?.validate() ?? false;
  }

  void resetForm() {
    setState(() => _submitted = false);
    formKey.currentState?.reset();
  }
}
```

**Used by:** All form pages (Login, Register, CreateTutoringRequest, CreateAppointmentRequest, WriteReview, ReportUser, AddEditSlot, etc.)

---

## `SnackBarMixin`
**Applied to:** `State<T>` of any page that shows feedback

```dart
mixin SnackBarMixin<T extends StatefulWidget> on State<T> {
  void showSuccessSnackBar(String message);
  void showErrorSnackBar(String message);
  void showInfoSnackBar(String message);
  void showWarningSnackBar(String message);
}
```

**Used by:** Every page that reacts to BLoC success/error states.

---

## `BlocFeedbackMixin`
**Applied to:** `State<T>` of pages using `BlocListener`

```dart
mixin BlocFeedbackMixin<T extends StatefulWidget> on State<T>
    implements SnackBarMixin<T> {
  void handleBlocError(String message) => showErrorSnackBar(message);
  void handleBlocSuccess(String message) => showSuccessSnackBar(message);
  void navigateOnSuccess(BuildContext context, String route) =>
      Navigator.of(context).pushReplacementNamed(route);
  void popOnSuccess(BuildContext context) => Navigator.of(context).pop();
}
```

**Used by:** Login, Register, CreateAppointmentRequest, WriteReview, ReportUser, CancelAppointment.

---

## `PaginationMixin`
**Applied to:** `State<T>` of any paginated list page

```dart
mixin PaginationMixin<T extends StatefulWidget> on State<T> {
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  bool hasReachedEnd = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isNearBottom && !isLoadingMore && !hasReachedEnd) loadNextPage();
  }

  bool get _isNearBottom =>
      scrollController.position.pixels >=
      scrollController.position.maxScrollExtent - 200;

  void loadNextPage(); // abstract — implemented by the page

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
```

**Used by:** BrowseTutorsPage, BrowseTutoringRequestsPage, MyReviewsPage, PaymentHistoryPage, HistoryPage, NotificationsPage.

---

## `CountdownMixin`
**Applied to:** `State<T>` of any page with an expiry deadline

```dart
mixin CountdownMixin<T extends StatefulWidget> on State<T> {
  Timer? _timer;
  Duration remaining = Duration.zero;

  void startCountdown(DateTime deadline) {
    _tick(deadline);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick(deadline));
  }

  void _tick(DateTime deadline) {
    final diff = deadline.difference(DateTime.now());
    setState(() => remaining = diff.isNegative ? Duration.zero : diff);
    if (diff.isNegative) {
      _timer?.cancel();
      onExpired();
    }
  }

  void onExpired(); // abstract — implemented by the page

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
```

**Used by:** `AppointmentRequestDetailPage`, `SessionConfirmationPage`, `ExpiryCountdown` widget.

---

## `DateTimeFormatterMixin`
**Applied to:** Any `State<T>` or widget that formats dates/times for display

```dart
mixin DateTimeFormatterMixin {
  String formatDate(DateTime dt);           // "Mon, 12 May 2026"
  String formatTime(DateTime dt);           // "14:30"
  String formatDateTime(DateTime dt);       // "Mon, 12 May · 14:30"
  String formatDuration(Duration d);        // "1h 30m"
  String formatRelative(DateTime dt);       // "2 hours ago" / "in 3 days"
  String formatCountdown(Duration d);       // "02:45:10"
  String formatDateShort(DateTime dt);      // "12 May"
  String formatCurrency(double amount, String currency); // "ILS 50.00"
}
```

**Used by:** All pages showing dates, times, durations, countdowns, or payment amounts.

---

## `AvatarFallbackMixin`
**Applied to:** `UserAvatar` and any widget rendering user avatars

```dart
mixin AvatarFallbackMixin {
  String initialsFromName(String name);     // "John Doe" → "JD"
  Color colorFromId(String id);             // deterministic pastel from hash
}
```

**Used by:** `UserAvatar`, `UserCard`, `TutorCard`, all list cards.

---

## `ScrollToTopMixin`
**Applied to:** `State<T>` of main tab pages

```dart
mixin ScrollToTopMixin<T extends StatefulWidget> on State<T> {
  final scrollController = ScrollController();

  void onTabReselected() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
```

**Used by:** BrowseTutorsPage, BrowseTutoringRequestsPage, SchedulePage, HistoryPage, NotificationsPage.

---

## `DeepLinkHandlerMixin`
**Applied to:** `State<T>` of `NotificationsPage` or any notification entry point

```dart
mixin DeepLinkHandlerMixin<T extends StatefulWidget> on State<T> {
  void handleNotificationTap(BuildContext context, AppNotification notification) {
    switch (notification.type) {
      case NotificationType.appointmentRequest:
        // navigate to AppointmentRequestDetailPage using notification.payload['requestId']
      case NotificationType.appointmentConfirmed:
      case NotificationType.appointmentCancelled:
        // navigate to AppointmentDetailPage
      case NotificationType.sessionConfirmationRequired:
        // navigate to SessionConfirmationPage
      case NotificationType.newReview:
        // navigate to MyReviewsPage
      case NotificationType.paymentReleased:
      case NotificationType.paymentRefunded:
        // navigate to PaymentDetailPage
      // ... exhaustive switch; compiler enforces all cases
    }
  }
}
```

**Used by:** `NotificationsPage`, `NotificationItem` tap handler.

---

## `ConfirmationDialogMixin`
**Applied to:** `State<T>` of any page that triggers destructive or important actions

```dart
mixin ConfirmationDialogMixin<T extends StatefulWidget> on State<T> {
  Future<bool> showDestructiveConfirmation({
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
  });

  Future<bool> showInfoConfirmation({
    required String title,
    required String message,
    String confirmLabel = 'OK',
  });
}
```

**Used by:** CancelAppointmentPage, AccountSettingsPage, CloseRequestButton, LogoutListTile.

---

## `FilePickerMixin`
**Applied to:** `State<T>` of any page with avatar or file upload

```dart
mixin FilePickerMixin<T extends StatefulWidget> on State<T> {
  Future<File?> pickImageFromGallery();
  Future<File?> pickImageFromCamera();
  Future<File> compressImage(File file, {int quality = 75, int maxDimension = 512});
}
```

**Used by:** `AvatarUploadWidget` (used in ProfileSetupPage, EditProfilePage).

---

## Summary

| Mixin | Applied To | Primary Pages |
|-------|-----------|---------------|
| `FormValidationMixin` | Form page `State` | Login, Register, CreateRequest, WriteReview, ReportUser, AddEditSlot |
| `SnackBarMixin` | Any page `State` | Universal |
| `BlocFeedbackMixin` | Pages with `BlocListener` | Login, Register, CreateAppointmentRequest, WriteReview |
| `PaginationMixin` | List page `State` | BrowseTutors, BrowseTutoringRequests, MyReviews, PaymentHistory, History |
| `CountdownMixin` | Pages with deadlines | AppointmentRequestDetail, SessionConfirmation |
| `DateTimeFormatterMixin` | Any `State` or widget | Universal (dates, durations, currencies) |
| `AvatarFallbackMixin` | Avatar widgets | UserAvatar, all list cards |
| `ScrollToTopMixin` | Main tab page `State` | BrowseTutors, Schedule, History, Notifications |
| `DeepLinkHandlerMixin` | Notification entry points | NotificationsPage |
| `ConfirmationDialogMixin` | Pages with destructive actions | CancelAppointment, AccountSettings, Logout |
| `FilePickerMixin` | Pages with file upload | ProfileSetup, EditProfile (via AvatarUploadWidget) |
