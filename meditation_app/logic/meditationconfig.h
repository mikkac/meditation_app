#ifndef MEDITATIONCONFIG_H
#define MEDITATIONCONFIG_H

#include <cstdint>

namespace med
{
struct MeditationConfig {
    uint16_t duration_s{6000};
    uint16_t time_left_s{6000};
};

} // namespace med

#endif // MEDITATIONCONFIG_H
