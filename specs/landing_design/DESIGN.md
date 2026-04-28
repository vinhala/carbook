---
name: Carbook Visual Identity
colors:
  surface: '#fcf9f2'
  surface-dim: '#dcdad3'
  surface-bright: '#fcf9f2'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f6f3ec'
  surface-container: '#f1eee7'
  surface-container-high: '#ebe8e1'
  surface-container-highest: '#e5e2db'
  on-surface: '#1c1c18'
  on-surface-variant: '#444842'
  inverse-surface: '#31312c'
  inverse-on-surface: '#f3f0e9'
  outline: '#747871'
  outline-variant: '#c4c8bf'
  surface-tint: '#526350'
  primary: '#50604d'
  on-primary: '#ffffff'
  primary-container: '#687965'
  on-primary-container: '#f7fff1'
  inverse-primary: '#baccb4'
  secondary: '#7b5900'
  on-secondary: '#ffffff'
  secondary-container: '#fecd6f'
  on-secondary-container: '#775600'
  tertiary: '#69594d'
  on-tertiary: '#ffffff'
  tertiary-container: '#827164'
  on-tertiary-container: '#fffbff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d6e8cf'
  primary-fixed-dim: '#baccb4'
  on-primary-fixed: '#111f10'
  on-primary-fixed-variant: '#3b4b39'
  secondary-fixed: '#ffdea4'
  secondary-fixed-dim: '#eec063'
  on-secondary-fixed: '#261900'
  on-secondary-fixed-variant: '#5d4200'
  tertiary-fixed: '#f5decf'
  tertiary-fixed-dim: '#d8c3b4'
  on-tertiary-fixed: '#241910'
  on-tertiary-fixed-variant: '#524439'
  background: '#fcf9f2'
  on-background: '#1c1c18'
  surface-variant: '#e5e2db'
typography:
  display-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 40px
    fontWeight: '700'
    lineHeight: 48px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  title-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
  label-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 16px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  gutter: 16px
  margin-mobile: 16px
  margin-tablet: 32px
---

## Brand & Style

This design system establishes a visual language described as "Rugged Utility." It balances the reliability required for automotive maintenance with an approachable, outdoorsy spirit. The aesthetic is inspired by high-end camping gear and modern overland vehicles: functional, durable, but meticulously clean.

The style leverages a **Tactile-Corporate hybrid** approach. It utilizes the structured hierarchy and functional logic of Material Design 3 while softening the mechanical feel through organic colors and subtle physical metaphors. The goal is to evoke a sense of trust and adventure, making car maintenance feel less like a chore and more like preparation for the next journey.

## Colors

The palette is derived from natural, sun-bleached landscapes. 

- **Backgrounds:** The light beige (#F4F1EA) serves as a warm, non-clinical canvas that reduces eye strain compared to pure white.
- **Primary Elements:** Sage green (#7A8B76) is used for primary actions, signifying growth and mechanical health.
- **Text & Accents:** Earthy bark brown (#4A3C31) provides high-contrast legibility while maintaining the organic theme. It replaces standard blacks or grays for a softer, more premium feel.
- **Highlights:** Mustard yellow (#E6B85C) is used sparingly for high-visibility alerts, badges, or "call to adventure" elements.

## Typography

This design system utilizes **Plus Jakarta Sans** for its friendly, rounded geometry and exceptional legibility. The typeface strikes a balance between professional engineering and approachable modernism.

- **Headlines:** Use Bold (700) weights with slightly tighter letter-spacing to create a sturdy, "stamped" look.
- **Body Text:** Use Regular (400) weights for long-form information to ensure maximum readability against the sand-colored background.
- **Labels:** Use SemiBold (600) and increased letter-spacing for all-caps subheadings or small UI labels to maintain a clean, organized hierarchy.

## Layout & Spacing

The layout follows a **Fluid Grid** model based on an 8px square rhythm. This ensures consistent alignment across various screen sizes while maintaining the organized "clean" aspect of the rugged aesthetic.

For mobile viewports, use a 4-column system with 16px margins. For larger displays, transition to a 12-column system. Elements should feel grounded; use generous padding (24px+) within cards to prevent the UI from feeling cluttered or "industrial," leaning instead toward a spacious, outdoorsy feel.

## Elevation & Depth

To create a tactile, approachable interface, this design system uses **Ambient Shadows** rather than harsh black shadows. 

- **Shadow Character:** Shadows should be soft, highly diffused, and tinted with the Earthy Brown accent color at very low opacity (e.g., 8-12%).
- **Card Depth:** Use a single, consistent elevation level for standard maintenance cards. When a card is "active" or "expanded," use a slightly deeper, more diffused shadow to simulate it lifting off the sand-colored surface.
- **Tonal Layers:** Use subtle shifts in the background color (slightly darker or lighter beige) to define header areas or navigation bars without relying solely on lines or heavy shadows.

## Shapes

The shape language is defined by **Rounded** geometry (Level 2). This softens the "rugged" nature of the app, making it feel friendly and modern rather than aggressive.

- **Primary Cards:** Use a 1rem (16px) corner radius.
- **Buttons & Chips:** Use fully rounded (pill-shaped) ends for secondary actions, and 0.5rem (8px) for primary action buttons to give them a sturdier appearance.
- **Inputs:** Maintain a 0.5rem radius to align with Material Design 3 standards, ensuring they feel like containers rather than just lines on a page.

## Components

Components follow Material Design 3 logic but are customized with the specific brand tokens:

- **Buttons:** Primary buttons use the Eucalyptus green background with white or very light beige text. They should have a subtle 1px inner stroke of a darker green to enhance the "tactile" feel.
- **Cards:** The core of the experience. Cards should have a white or slightly-off-white background (#FAF9F6) to pop against the sand base. They feature 16px rounded corners and a soft brown-tinted shadow.
- **Chips/Status:** Use mustard yellow for "Upcoming Service" and sage green for "Completed." Chips should be pill-shaped.
- **Input Fields:** Filled style with a very subtle beige tint. Use the bark brown for the bottom indicator line and label text.
- **Lists:** Maintenance logs should be grouped into cards with clear dividers. Use the bark brown for icons to keep the interface grounded.
- **Additional Suggestion:** **Progress Rings.** For vehicle health or fuel levels, use thick, rounded stroke progress rings in eucalyptus green to reinforce the friendly, graphical nature of the app.