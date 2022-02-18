#ifndef __PFD_H
#define __PFD_H

#ifdef __cplusplus
extern "C" {
#endif

extern void pfd_notification(const char* title, const char* message, int ic);
extern int pfd_message(const char* title, const char* message, int tp, int ic);
extern char* pfd_select_folder(const char* title, const char* path);
extern char* pfd_select_file(const char* title, const char* path);

#ifdef __cplusplus
}
#endif

#endif
