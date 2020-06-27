package pl.bartekpacia.zelrap

import io.flutter.embedding.android.FlutterActivity
import io.getstream.cloud.CloudClient
import io.getstream.core.models.Activity
import io.getstream.core.options.Limit
import java.util.UUID

class MainActivity: FlutterActivity() {
    private val CHANNEL = "pl.bartekpacia/zelrap"
    private val API_KEY = "b7z2e3m6kfa2"

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
}
