#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

void sete(char* key, const char* appdir, char* suffix) {
  char path[200];
  strcpy(path, appdir);
  strcat(path, suffix);
  printf("%s %s\n", key, path);
  setenv(key, path, 1);
}

int main(int argc, char* argv[]) {
  int status;
  const char *appdir = getenv("APPDIR");

  sete("QT_PLUGIN_PATH", appdir, "/usr/lib/qt4/plugins");
  sete("LD_LIBRARY_PATH", appdir, "/usr/lib");
  sete("MARBLE_PLUGIN_PATH", appdir, "/usr/lib/kde4/plugins");
  sete("MARBLE_DATA_PATH", appdir, "/usr/share/kde4/apps");

  //status = system("env");

  char path[200];
  strcpy(path, appdir);
  strcat(path, "/usr/bin/igotugui");
  printf("run: %s\n", path);
  status = system(path);
  return status;
  //argv[0] = path;
  //execve(path, argv, NULL);
}
