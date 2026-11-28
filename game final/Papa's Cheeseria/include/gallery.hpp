// gallery.hpp — écran de debug : parcourt tous les sprites exportés
#pragma once
#include <3ds.h>
#include <citro2d.h>

namespace cheeseria {

bool galleryActive();
void galleryOpen();
void galleryFrame(u32 kDown, touchPosition tp, bool touched,
                  C3D_RenderTarget* top, C3D_RenderTarget* bottom, C2D_TextBuf tb);

} // namespace cheeseria
