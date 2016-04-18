
// sacado directamente de minim para aplicar el efecto reverse//
class Efecto implements AudioEffect
{
  void process(float[] samp)
  {
    float[] reversed = new float[samp.length];
    int i = samp.length - 1;
    for (int j = 0; j < reversed.length; i--, j++)
    {
      reversed[j] = samp[i];
    }
    arraycopy(reversed, samp);
  }
 
  void process(float[] left, float[] right)
  {
    process(left);
    process(right);
  }
}
