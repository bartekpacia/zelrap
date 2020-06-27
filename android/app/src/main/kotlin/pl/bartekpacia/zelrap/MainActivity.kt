package pl.bartekpacia.zelrap

import com.fasterxml.jackson.databind.ObjectMapper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.getstream.cloud.CloudClient
import io.getstream.core.models.Activity
import io.getstream.core.options.Limit
import java.util.UUID

class MainActivity : FlutterActivity() {
    private val CHANNEL = "pl.bartekpacia/zelrap"
    private val API_KEY = "b7z2e3m6kfa2"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "postMessage" -> {
                    postMessage(
                        call.argument<String>("user")!!,
                        call.argument<String>("token")!!,
                        call.argument<String>("message")!!
                    )
                    result.success(true)
                }
                "getActivities" -> {
                    val activities = getActivities(
                        call.argument<String>("user")!!,
                        call.argument<String>("token")!!
                    )
                    result.success(ObjectMapper().writeValueAsString(activities))
                }
                "getTimeline" -> {
                    val activities = getTimeline(
                        call.argument<String>("user")!!,
                        call.argument<String>("token")!!
                    )
                    result.success(ObjectMapper().writeValueAsString(activities))
                }
                "follow" -> {
                    follow(
                        call.argument<String>("user")!!,
                        call.argument<String>("token")!!,
                        call.argument<String>("userToFollow")!!
                    )
                    result.success(true)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun postMessage(user: String, token: String, message: String) {
        val client = CloudClient.builder(API_KEY, token, user).build()

        val feed = client.flatFeed("user")
        feed.addActivity(
            Activity
                .builder()
                .actor("SU:${user}")
                .verb("post")
                .`object`(UUID.randomUUID().toString())
                .extraField("message", message)
                .build()
        ).join()
    }

    private fun getActivities(user: String, token: String): List<Activity> {
        val client = CloudClient.builder(API_KEY, token, user).build()

        return client.flatFeed("user").getActivities(Limit(25)).join()
    }

    private fun getTimeline(user: String, token: String): List<Activity> {
        val client = CloudClient.builder(API_KEY, token, user).build()

        return client.flatFeed("timeline").getActivities(Limit(25)).join()
    }

    private fun follow(user: String, token: String, userToFollow: String): Boolean {
        val client = CloudClient.builder(API_KEY, token, user).build()

        client.flatFeed("timeline").follow(client.flatFeed("user", userToFollow)).join()
        return true
    }
}
