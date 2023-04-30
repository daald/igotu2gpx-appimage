#include <unistd.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char* argv[]) {
  int status;
  const char *appdir = getenv("APPDIR");
  char path[200];

  strcpy(path, appdir);
  strcat(path, "/usr/lib/qt4/plugins");
  printf("QT_PLUGIN_PATH %s\n", path);
  setenv("QT_PLUGIN_PATH", path, 1);

  strcpy(path, appdir);
  strcat(path, "/usr/lib");
  printf("LD_LIBRARY_PATH %s\n", path);
  setenv("LD_LIBRARY_PATH", path, 1);

  //status = system("env");

  strcpy(path, appdir);
  strcat(path, "/usr/bin/igotugui");
  printf("run: %s\n", path);
  status = system(path);
  return status;
  //argv[0] = path;
  //execve(path, argv, NULL);
}
