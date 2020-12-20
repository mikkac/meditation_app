#ifndef MEDITATIONCONFIG_H
#define MEDITATIONCONFIG_H

#include <cstdint>

namespace med
{

struct MeditationConfig
{
    uint16_t duration_s{};
    uint16_t time_left_s{};
};

} // namespace med

#endif // MEDITATIONCONFIG_H
