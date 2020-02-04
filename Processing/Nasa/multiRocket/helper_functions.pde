
void rotate(float z, float y, float x) {
  rotateY(z);
  rotateX(y);
  rotateZ(x);
}

float[] llaToXyz(float lon, float lat, float alt, int r) {
  r += alt;
  float[] xyz = {r*sin(lon)*cos(lat), r*sin(lon)*sin(lat), r*cos(lon)};
  return xyz;
}

float[] QuatToYRP(float q0, float q1, float q2, float q3) {
  float yrp[] = new float[3];
  // roll
  yrp[0] = atan2(2*(q0*q1 + q2*q3), 1 - 2*(q1*q1 + q2*q2));
  // pitch
  yrp[1] = asin(2*(q0*q2 - q3*q1));
  // yaw
  yrp[2] = atan2(2*(q0*q3 + q1*q2), 1 - 2*(q2*q2 + q3*q3));
  return yrp;
}
