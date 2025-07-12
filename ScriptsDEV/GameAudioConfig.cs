using System;

namespace ZeitKrieg.Config
{
    [Serializable]
    public class GameAudioConfig
    {
        public float MasterVolume { get; set; } = 0.8f;
        public float MusicVolume { get; set; } = 0.7f;
        public float SFXVolume { get; set; } = 0.9f;
        public bool MuteAll { get; set; } = false;
        public string AudioOutputDevice { get; set; } = "Default";

        public override string ToString()
        {
            return $"MasterVolume: {MasterVolume}, MusicVolume: {MusicVolume}, SFXVolume: {SFXVolume}, MuteAll: {MuteAll}, Device: {AudioOutputDevice}";
        }
    }
}