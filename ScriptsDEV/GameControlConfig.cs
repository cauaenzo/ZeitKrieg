using System;
using System.Collections.Generic;

namespace ZeitKrieg.Config
{
    [Serializable]
    public class GameControlConfig
    {
        public Dictionary<string, string> KeyBindings { get; set; } = new Dictionary<string, string>
        {
            { "Jump", "Space" },
            { "Shoot", "LeftCtrl" },
            { "MoveLeft", "A" },
            { "MoveRight", "D" },
            { "Pause", "Escape" }
        };

        public float MouseSensitivity { get; set; } = 1.2f;
        public bool InvertYAxis { get; set; } = false;

        public override string ToString()
        {
            var keys = string.Join(", ", KeyBindings);
            return $"Bindings: {keys}, MouseSensitivity: {MouseSensitivity}, InvertYAxis: {InvertYAxis}";
        }
    }
}