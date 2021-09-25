using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;

namespace AssetRipper
{
    class Program
    {
        static byte[] cPngStart = { 0x89, (byte)'P', (byte)'N', (byte)'G', 0x0D, 0x0A, 0x1A, 0x0A };
        static byte[] cPngEnd = { (byte)'I', (byte)'E', (byte)'N', (byte)'D', 0xAE, 0x42, 0x60, 0x82};

        static List<int> GetPngIndices(byte[] file)
        {
            List<int> pngIndices = new List<int>();

            for(int i = 0; i < file.Length; i++)
            {
                bool matchFound = true;

                for(int j = 0; j < cPngStart.Length; j++)
                {
                    if (file[i + j] != cPngStart[j])
                    {
                        matchFound = false;
                        break;
                    }
                }

                if (matchFound)
                    pngIndices.Add(i);
            }

            return pngIndices;
        }

        static int GenerateSpriteSheets()
        {
            byte[] file = File.ReadAllBytes("data.win");
            List<int> pngIndices = GetPngIndices(file);

            int imageIndex = 0;
            foreach (int startingIndex in pngIndices)
            {
                List<byte> tempList = new List<byte>();

                bool done = false;
                int index = startingIndex;
                while (!done)
                {
                    tempList.Add(file[index]);
                    index++;

                    bool endFound = true;
                    for (int i = 0; i < cPngEnd.Length; i++)
                    {
                        if (file[i + index] != cPngEnd[i])
                        {
                            endFound = false;
                            break;
                        }

                    }

                    if (endFound)
                    {
                        foreach (byte b in cPngEnd)
                            tempList.Add(b);

                        done = true;

                        File.WriteAllBytes("Assets/Img_" + imageIndex + ".png", tempList.ToArray());
                        imageIndex++;
                    }
                }
            }

            return imageIndex;
        }

        static Bitmap SaveSection(Bitmap source, Rectangle rect, List<Color> palette, Bitmap copyFrom)
        {
            Bitmap section = source.Clone(rect, PixelFormat.Format32bppArgb);
            for(int y = 0; y < rect.Height; y++)
            {
                for(int x = 0; x < rect.Width; x++)
                {
                    Color color = section.GetPixel(x, y);

                    if(!palette.Contains(color) || color == Color.FromArgb(0,0,0,0))
                        section.SetPixel(x, y, Color.FromArgb(255, 255, 255, 255));

                }
            }

            if (copyFrom != null)
            {

                var combined = new Bitmap(copyFrom.Width + section.Width, Math.Max(copyFrom.Height, section.Height), PixelFormat.Format24bppRgb);
                var graphics = Graphics.FromImage(combined);
                graphics.DrawImage(copyFrom, 0, 0);
                graphics.DrawImage(section, copyFrom.Width, 0);
                return combined;
            }
            return section;
        }

        static void Main(string[] args)
        {
            int numSpriteSheets = GenerateSpriteSheets();
            Console.WriteLine("Generating sprite sheets");

            Bitmap spriteSheet = new Bitmap("Assets/Img_25.png");

            Bitmap krisIdle = spriteSheet.Clone(new Rectangle(120, 1027, 40, 48), PixelFormat.Format32bppArgb);
            spriteSheet.Dispose();

            List<Color> KrisPalette0 = new List<Color> { Color.FromArgb(255, 255, 255, 255), Color.FromArgb(117, 251, 237), Color.FromArgb(106, 123, 196), Color.FromArgb(11, 11, 59) };
            List<Color> KrisPalette1 = new List<Color> { Color.FromArgb(255, 255, 255, 255), Color.FromArgb(255, 215, 215), Color.FromArgb(242, 161, 161), Color.FromArgb(72, 1, 46) };
            List<Color> KrisPalette2 = new List<Color> { Color.FromArgb(255, 255, 255, 255), Color.FromArgb(235, 0, 149), Color.FromArgb(199, 227, 242), Color.FromArgb(131, 21, 90) };

            Bitmap kris0_0;
            kris0_0 = SaveSection(krisIdle, new Rectangle(0, 0, 24, 16), KrisPalette0, null);
            kris0_0 = SaveSection(krisIdle, new Rectangle(0, 16, 16, 16), KrisPalette0, kris0_0);
            kris0_0 = SaveSection(krisIdle, new Rectangle(16, 16, 16, 16), KrisPalette0, kris0_0);
            kris0_0 = SaveSection(krisIdle, new Rectangle(0, 32, 24, 16), KrisPalette0, kris0_0);
            kris0_0.Save("Assets/Kris_Idle0-0.png", ImageFormat.Png);
            Console.WriteLine("Outputting Kris_Idle0-0.png");

            Bitmap kris0_1;
            kris0_1 = SaveSection(krisIdle, new Rectangle(24, 0, 16, 16), KrisPalette1, null);
            kris0_1 = SaveSection(krisIdle, new Rectangle(16, 16, 16, 16), KrisPalette1, kris0_1);
            kris0_1.Save("Assets/Kris_Idle0-1.png", ImageFormat.Png);
            Console.WriteLine("Outputting Kris_Idle0-1.png");

            Bitmap kris0_2;
            kris0_2 = SaveSection(krisIdle, new Rectangle(0, 16, 16, 16), KrisPalette2, null);
            kris0_2 = SaveSection(krisIdle, new Rectangle(16, 16, 16, 16), KrisPalette2, kris0_2);
            kris0_2 = SaveSection(krisIdle, new Rectangle(8, 32, 16, 16), KrisPalette2, kris0_2);
            kris0_2.Save("Assets/Kris_Idle0-2.png", ImageFormat.Png);
            Console.WriteLine("Outputting Kris_Idle0-2.png");

            Console.WriteLine("Deleting sprite sheets");
            for(int i = 0; i < numSpriteSheets; i++)
            {
                File.Delete("Assets/Img_" + i + ".png");
            }
        }

        
    }
}
