#ifndef MEDITATIONSTATE_H
#define MEDITATIONSTATE_H

#include <cstdint>

namespace med
{

enum class MeditationState
{
    STARTED = 0,
    PAUSED,
    STOPPED,
    IDLE,
};

} // namespace med

#endif // MEDITATIONSTATE_H
