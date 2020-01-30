#ifndef __ART_VERSION_H__
#define __ART_VERSION_H__

static unsigned char Version[] = {
  0x30, 0x2e, 0x38
};
static unsigned int Version_len = 3;
static unsigned char BuildNo[] = {
  0x31, 0x31, 0x31, 0x32, 0x33
};
static unsigned int BuildNo_len = 5;
static unsigned char BuildDate[] = {
  0x33, 0x30, 0x2d, 0x4a, 0x61, 0x6e, 0x2d, 0x32, 0x30, 0x32, 0x30
};
static unsigned int BuildDate_len = 11;

static inline void showVersion() {
struct utsname unameData;
uname(&unameData);
printf("\x1B[32m\x1B[1mArturo %.*s\x1B[0m (%.*s build %.*s) [%s-%s]\n",3,Version,11,BuildDate,5,BuildNo,unameData.machine,unameData.sysname);
printf("(c) 2019-2020 Yanis Zafirópulos\n");
printf("\n");
}
#endif
