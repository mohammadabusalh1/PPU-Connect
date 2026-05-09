# Rive Animations — Design Spec

All `.riv` files in this folder are **placeholders**. Replace each with a real
Rive file exported from https://rive.app before shipping.

Wrap every `RiveAnimation.asset(...)` call in a `try/catch` or check file
validity; the placeholder bytes will cause a parse exception at runtime.

---

## Files to build in Rive editor

| File | State machine | Description |
|------|--------------|-------------|
| `notification_bell.riv` | `idle` → `ring` | Bell rings 3× on new notification (spring curve); idle stays still |
| `onboarding.riv` | `idle` | Parallax illustration: foreground moves 2× faster than background on scroll/gyro |
| `role_seeker.riv` | `idle` → `selected` | Person-looking icon; triggers play animation on card select |
| `role_tutor.riv` | `idle` → `selected` | Graduation cap icon; same trigger |
| `role_both.riv` | `idle` → `selected` | Two-people icon; same trigger |
| `complete_button.riv` | `idle` → `tap` | Shimmer idle; tap: particle burst from center, spring scale 0.95→1.05→1.0 |
| `slot_fab.riv` | `idle` → `tap` → `done` | `+` icon → checkmark morph; expand pulse on scroll-up reveal |
| `accepting_toggle.riv` | `off` → `on` | Track color grey↔green; thumb slides with spring overshoot (200 ms) |
| `accept_button.riv` | `idle` → `tap` | Green burst + scale + checkmark draw |
| `reject_button.riv` | `idle` → `tap` | Red shake + X morph |
| `send_request_fab.riv` | `idle` → `tap` | Shimmer idle; tap: scale + particle burst |
| `confirm_button.riv` | `idle` → `hover` → `tap` → `success` | Shimmer → checkmark draw → green burst → large checkmark morph |
| `delete_swipe.riv` | `hidden` → `revealed` | Red background slides in from right with trash icon |

---

## Suggested tools
- Rive editor: https://rive.app (free tier supports all required state machines)
- Export: File → Export → Runtime — choose **Rive runtime format (.riv)**
- Flutter integration: `rive` package already declared in `pubspec.yaml`
