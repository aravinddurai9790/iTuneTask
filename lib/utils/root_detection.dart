import 'package:root_jailbreak_sniffer/rjsniffer.dart';

class RootDetection {
  static Future<bool> isDeviceRooted() async {
    return (await isRooted());
  }

  static Future<bool> isRooted() async {
    // Check for root access using various methods
    bool amICompromised =
        await Rjsniffer.amICompromised() ?? false; //Detect JailBreak and Root
    bool amIDebugged =
        await Rjsniffer.amIDebugged() ?? false; //Detect being Debugged
    bool amIEmulator =
        await Rjsniffer.amIEmulator() ?? false; //Detect Emulator Environment
    //If one of the falg is true then app will not move to home screen
    if (amIDebugged || amIEmulator || amICompromised) {
      return true;
    }

    return false; // Placeholder
  }
}
