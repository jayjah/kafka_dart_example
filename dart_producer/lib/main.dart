import 'package:kafka/kafka.dart';

Future<void> main() async {
  var config = ProducerConfig(bootstrapServers: ['127.0.0.1:9092']);
  var producer =
      Producer<String, String>(StringSerializer(), StringSerializer(), config);

  for (var i = 0; i < 10; i++) {
    // Loop through a list of partitions.
    for (var p in [1]) {
      var rec = ProducerRecord('Topic1', p, 'key:${p},$i', 'value:${p},$i');
      producer.add(rec);
      rec.result.then(print);
    }
  }
  await producer.close();
}
