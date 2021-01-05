#ifndef MEDITATIONCONFIG_H
#define MEDITATIONCONFIG_H

#include <cstdint>

namespace med
{
struct MeditationConfig {
    uint16_t duration_s{600};
    uint16_t time_left_s{600};
};

} // namespace med

#endif // MEDITATIONCONFIG_H
