import 'package:kafka/kafka.dart';

Future<void> main() async {
  var session = Session(['127.0.0.1:9092']);
  var consumer = Consumer<String, String>(
      'Topic1', StringDeserializer(), StringDeserializer(), session);

  await consumer.subscribe(['Topic1']);
  consumer.seekToEnd();
  var queue = consumer.poll();
  while (await queue.moveNext()) {
    var records = queue.current;
    for (var record in records.records) {
      print(
          "[${record.topic}:${record.partition}], offset: ${record.offset}, ${record.key}, ${record.value}, ts: ${record.timestamp}");
    }
    // await consumer.commit();
  }
  await session.close();
}
