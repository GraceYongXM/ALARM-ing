//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import assets_audio_player
import assets_audio_player_web
<<<<<<< HEAD
import audio_session
import cloud_firestore
import firebase_auth
=======
>>>>>>> 64c941af848497f29c9cc082be41ed29a2d7d3cd
import firebase_core
import firebase_database
import path_provider_macos

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AssetsAudioPlayerPlugin.register(with: registry.registrar(forPlugin: "AssetsAudioPlayerPlugin"))
  AssetsAudioPlayerWebPlugin.register(with: registry.registrar(forPlugin: "AssetsAudioPlayerWebPlugin"))
<<<<<<< HEAD
  AudioSessionPlugin.register(with: registry.registrar(forPlugin: "AudioSessionPlugin"))
  FLTFirebaseFirestorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseFirestorePlugin"))
  FLTFirebaseAuthPlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseAuthPlugin"))
=======
>>>>>>> 64c941af848497f29c9cc082be41ed29a2d7d3cd
  FLTFirebaseCorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseCorePlugin"))
  FLTFirebaseDatabasePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseDatabasePlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
}
