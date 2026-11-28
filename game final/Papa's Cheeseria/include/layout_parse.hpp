// layout_parse.hpp — analyse d'une ligne de layout/screens.tsv (pur, testable sur PC)
// Format (séparateur TAB) : ecran  cible(top|bottom)  sprite  x  y  [sx  sy]
// Lignes vides et lignes commençant par '#' ignorées.
#pragma once
#include <cstdlib>
#include <cstring>
#include <string>

namespace cheeseria {

struct LayoutOp {
    std::string screen;
    bool        top = true;
    std::string sprite;
    float       x = 0, y = 0, sx = 1, sy = 1;
};

inline bool parseLayoutLine(const char* line, LayoutOp& op) {
    if (!line) return false;
    std::string s(line);
    while (!s.empty() && (s.back() == '\n' || s.back() == '\r')) s.pop_back();
    if (s.empty() || s[0] == '#') return false;

    std::string f[7];
    int n = 0;
    std::size_t pos = 0;
    while (n < 7) {
        std::size_t t = s.find('\t', pos);
        f[n++] = s.substr(pos, t == std::string::npos ? std::string::npos : t - pos);
        if (t == std::string::npos) break;
        pos = t + 1;
    }
    if (n < 5 || f[0].empty() || f[2].empty()) return false;
    if (f[1] != "top" && f[1] != "bottom") return false;

    char* end = nullptr;
    float v[4] = {0, 0, 1, 1};
    for (int i = 0; i < 4; ++i) {
        if (i + 3 >= n) break;                       // sx/sy facultatifs
        v[i] = std::strtof(f[i + 3].c_str(), &end);
        if (end == f[i + 3].c_str()) return false;   // nombre invalide
    }
    if (n == 6) v[3] = v[2];                         // sx seul => échelle uniforme
    op.screen = f[0];
    op.top = (f[1] == "top");
    op.sprite = f[2];
    op.x = v[0]; op.y = v[1]; op.sx = v[2]; op.sy = v[3];
    return true;
}

} // namespace cheeseria
