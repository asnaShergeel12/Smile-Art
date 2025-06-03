import 'package:supabase_flutter/supabase_flutter.dart';
import 'model/aligner_info_model.dart';

class AlignerInfoService {
  static final AlignerInfoService _alignerInfoService = AlignerInfoService._internal();
  factory AlignerInfoService() => _alignerInfoService;
  AlignerInfoService._internal();
  final supabase = Supabase.instance.client;

  Future<String?> alignerInfo(
      String totalAlignerNumber,
      String currentAligner,
      String alignerWearDays,
      DateTime reminder,
      ) async {
    try {
      // Convert strings to integers
      final int? total = int.tryParse(totalAlignerNumber);
      final int? current = int.tryParse(currentAligner);
      final int? wearDays = int.tryParse(alignerWearDays);

      // Validate that parsing succeeded
      if (total == null || current == null || wearDays == null ) {
        throw Exception("Invalid input: failed to parse one or more values.");
      }

      final user = supabase.auth.currentUser;
      if (user == null) throw Exception("User not logged in");

      final model = AlignerInfoModel(
        userId: user.id,
        totalAlignerNumber: total,
        currentAlignerNumber: current,
        alignerWearDays: wearDays,
        reminder: reminder,
      );


      final response = await supabase.from('aligner_info').insert(model.toJson()).select();
      print('Aligners Info successfully uploaded to database: $response');

      return "Success";
    } catch (e) {
      print('Error in alignerInfo: $e');
      return null;
    }
  }

}