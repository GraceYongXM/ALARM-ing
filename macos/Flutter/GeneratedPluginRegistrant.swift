//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import assets_audio_player
import assets_audio_player_web
import cloud_firestore
import firebase_auth
import firebase_core
import firebase_database
import path_provider_macos

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AssetsAudioPlayerPlugin.register(with: registry.registrar(forPlugin: "AssetsAudioPlayerPlugin"))
  AssetsAudioPlayerWebPlugin.register(with: registry.registrar(forPlugin: "AssetsAudioPlayerWebPlugin"))
  FLTFirebaseFirestorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseFirestorePlugin"))
  FLTFirebaseAuthPlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseAuthPlugin"))
  FLTFirebaseCorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseCorePlugin"))
  FLTFirebaseDatabasePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseDatabasePlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
}
