# Zigpoll — GTM Web Tag Template

A Google Tag Manager web tag template for [Zigpoll](https://www.zigpoll.com) surveys, polls, and quizzes. Load the Zigpoll widget via GTM with consent control.

## Features

- **Widget Loading** — Load the Zigpoll script via GTM
- **Account Configuration** — Set your account ID through the template UI
- **Specific Poll Override** — Optionally force a specific poll to display
- **Built-in Analytics** — Zigpoll automatically pushes events to the dataLayer for GA4 tracking
- **Debug Mode** — Console logging for troubleshooting

## Setup

### 1. Create the GTM Tag

1. In GTM, go to **Templates > Tag Templates > Search Gallery**
2. Search for **Zigpoll** (by New North Digital)
3. Add to workspace
4. Create a new tag using the **Zigpoll** template
5. Enter your **Account ID** (found in the Zigpoll dashboard or embed code)
6. Set the trigger to **All Pages**

### 2. Track Zigpoll Events in GA4

Zigpoll automatically pushes events to the dataLayer when users interact with polls. To forward these to GA4:

1. Create a **Custom Event Trigger** for event name `gaEvent`
2. Add a condition: `eventCategory equals Zigpoll`
3. Create **Data Layer Variables**:
   - `eventAction` — The interaction type (e.g., "Poll Completed")
   - `eventLabel` — The poll title
   - `zigpoll_question` — The question answered
   - `zigpoll_response` — The response given
4. Create a **GA4 Event Tag** mapping these parameters

## Template Fields

| Field | Required | Description |
|-------|----------|-------------|
| Account ID | Yes | Your Zigpoll account ID |
| Poll ID | No | Force a specific poll (overrides targeting rules) |

## Important Note

Zigpoll recommends adding the script directly to your website for best performance. Loading via GTM may introduce a slight delay and the widget may not appear in Safari Incognito or with Safari Advanced Protection enabled.

## Permissions

- **Inject Scripts** — Loads `https://cdn.zigpoll.com/static/js/main.js`
- **Access Global Variables** — Write `window.Zigpoll` configuration
- **Logging** — Console logging in debug/preview mode only

## Resources

- [Zigpoll Documentation](https://docs.zigpoll.com)
- [Zigpoll GTM Guide](https://docs.zigpoll.com/integrations/google-tag-manager)
- [Zigpoll JavaScript API](https://docs.zigpoll.com/javascript-api)

## Author

Created by [New North Digital](https://newnorth.digital?utm_source=github&utm_medium=gtm-template&utm_campaign=zigpoll-web-tag)

## License

Apache 2.0 — see [LICENSE](LICENSE).
