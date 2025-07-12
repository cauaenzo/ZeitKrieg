using System;

namespace ZeitKrieg.Config
{
    [Serializable]
    public class GameGraphicsConfig
    {
        public int ResolutionWidth { get; set; } = 1920;
        public int ResolutionHeight { get; set; } = 1080;
        public bool Fullscreen { get; set; } = true;
        public int VSync { get; set; } = 1;
        public string TextureQuality { get; set; } = "High";
        public int ShadowQuality { get; set; } = 2; // 0: Off, 1: Low, 2: High

        public override string ToString()
        {
            return $"Resolution: {ResolutionWidth}x{ResolutionHeight}, Fullscreen: {Fullscreen}, VSync: {VSync}, TextureQuality: {TextureQuality}, ShadowQuality: {ShadowQuality}";
        }
    }
}