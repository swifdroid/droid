plugins {
    id("com.android.library")
    id("maven-publish")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "stream.swift.droid.appkit"
    compileSdk = 35

    defaultConfig {
        minSdk = 24
        consumerProguardFiles("consumer-rules.pro")
    }

    buildTypes {
        release {
            isMinifyEnabled = false
        }
    }

    publishing {
        singleVariant("release") {
            withSourcesJar()
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }
}
dependencies {
    implementation(libs.androidx.annotation.jvm)
    implementation(libs.androidx.appcompat)
}

publishing {
    publications {
        afterEvaluate {
            val releaseComponent = components.findByName("release")
            if (releaseComponent != null) {
                create<MavenPublication>("release") {
                    from(releaseComponent)

                    groupId = "com.github.swifdroid"
                    artifactId = "appkit"
                    version = "1.0.0-beta.2"

                    pom {
                        name.set("Droid App UI Library")
                        description.set("App UI Library for Swift on Android")
                        url.set("https://github.com/swifdroid/droid")

                        licenses {
                            license {
                                name.set("MIT License")
                                url.set("http://www.opensource.org/licenses/mit-license.php")
                            }
                        }

                        developers {
                            developer {
                                id.set("imike")
                                name.set("Mikhail Isaev")
                                email.set("imike@swift.stream")
                            }
                        }

                        scm {
                            connection.set("scm:git:https://github.com/swifdroid/droid.git")
                            developerConnection.set("scm:git:ssh://git@github.com/swifdroid/droid.git")
                            url.set("https://github.com/swifdroid/droid")
                        }
                    }
                }
            }
        }
    }
}
