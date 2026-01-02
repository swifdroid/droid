<p align="center">
<img width="480" alt="Image" src="https://github.com/user-attachments/assets/274c8464-6a21-4ffc-8c17-d18bb7bb4305" />
</p>

# Droid – Android Development in Swift

Droid is a modern framework that lets you build native Android applications entirely in Swift – without touching XML, Java, or Kotlin.

If you love Swift’s expressiveness and want to bring it to the Android world, Droid is for you.

## ✨ Why Droid?

- **Pure Swift** — UI, manifest, lifecycle, and configuration in one language
- **Declarative UI** — familiar, readable, and composable
- **No XML** — ever
- **Native Android** — not a web wrapper, not a transpiler
- **One place for everything** — UI, manifest, Gradle dependencies

Droid aims to make Android development feel as natural and elegant as modern Swift development.

## 🧱 Declarative UI

Build Android UIs using clean, Swift-first APIs:

```swift
ConstraintLayout {
    VStack {
        TextView("Hello from Swift!")
            .width(.matchParent)
            .height(.wrapContent)
            .textColor(.green)
        MaterialButton("Tap Me")
            .onClick {
                print("Button tapped!")
            }
    }
    .centerVertical()
    .leftToParent()
    .rightToParent()
}
```

Simple. Declarative. Beautiful.

## 📄 Manifest in Swift

Even the Android manifest is written in Swift:

```swift
@main
public final class App: DroidApp {
	@AppBuilder public override var body: Content {
        Lifecycle.didFinishLaunching{
			App.setLogLevel(.debug)
			// App.setInnerLogLevel(.trace)
			Log.i("🚀 didFinishLaunching")
		}
		Manifest
			// .usesPermissions(.camera)
			// .usesFeatures(.hardwareCamera)
			.application {
				.allowBackup()
				.icon("@mipmap/ic_launcher")
				.roundIcon("@mipmap/ic_launcher_round")
				.label("My app")
				.theme(.material3DayNightNoActionBar)
				.activities(
					MainActivity.self
				)
				.fragments(
					HomeFragment.self,
					DashboardFragment.self,
					NotificationsFragment.self
				)
			}
    }
}
```
No context switching. No duplicated configuration. No hidden magic.

## 📚 Documentation

📖 **Docs**: http://docs.swifdroid.com/app/

The documentation is **well written and actively evolving**.  
Android is massive, and while not everything is documented yet, existing guides are carefully crafted and expanded continuously.

You can **start building today** with **[Swift Stream IDE](https://swift.stream)**.

## 🧩 What’s Supported

- Classic Android widgets
- AndroidX
- Material Design
- Flexbox layouts

## 🚧 Project Status

Droid is under **active development** and evolving rapidly.  
APIs may grow and improve, but the core vision is stable and clear.

Feedback is not only welcome – it’s encouraged.

## 🌍 Community & Feedback

- 🐞 Issues: https://github.com/swifdroid/droid/issues
- 💬 Discord: https://discord.com/invite/Wh3n86ttRB
- 📢 Telegram: https://t.me/+t9zXkfjoKNNlY2Ri

If the project resonates with you, please consider giving it a ⭐️
