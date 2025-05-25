#include <foundation/bootstrap/bootstrap.h>

using namespace cupix::foundation;

int main() {
  bootstrap::load();
  {
  }
  bootstrap::unload();

  return 0;
}
