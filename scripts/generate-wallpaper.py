#!/usr/bin/env python3
"""Generate a dark geometric grayscale wallpaper for Hyprland."""

import random
import struct
import zlib
import os
import sys

WIDTH = 1920
HEIGHT = 1080
BG = (10, 10, 10)


def lerp(a, b, t):
    return int(a + (b - a) * t)


def clamp(v, lo=0, hi=255):
    return max(lo, min(hi, v))


def blend(base, overlay, alpha):
    return tuple(clamp(lerp(b, o, alpha)) for b, o in zip(base, overlay))


def draw_line(pixels, x0, y0, x1, y1, color, alpha=1.0, thickness=1):
    dx = abs(x1 - x0)
    dy = abs(y1 - y0)
    sx = 1 if x0 < x1 else -1
    sy = 1 if y0 < y1 else -1
    err = dx - dy

    while True:
        for t in range(-thickness // 2, thickness // 2 + 1):
            for s in range(-thickness // 2, thickness // 2 + 1):
                px, py = x0 + s, y0 + t
                if 0 <= px < WIDTH and 0 <= py < HEIGHT:
                    base = pixels[py][px]
                    pixels[py][px] = blend(base, color, alpha)
        if x0 == x1 and y0 == y1:
            break
        e2 = 2 * err
        if e2 > -dy:
            err -= dy
            x0 += sx
        if e2 < dx:
            err += dx
            y0 += sy


def draw_triangle_edges(pixels, pts, color, alpha, thickness=1):
    for i in range(3):
        x0, y0 = pts[i]
        x1, y1 = pts[(i + 1) % 3]
        draw_line(pixels, x0, y0, x1, y1, color, alpha, thickness)


def generate_wallpaper(output_path):
    random.seed(42)

    pixels = [[BG for _ in range(WIDTH)] for _ in range(HEIGHT)]

    points = []
    grid_x, grid_y = 14, 9
    for gy in range(-1, grid_y + 2):
        for gx in range(-1, grid_x + 2):
            bx = int(gx * WIDTH / grid_x)
            by = int(gy * HEIGHT / grid_y)
            jx = random.randint(-60, 60)
            jy = random.randint(-40, 40)
            points.append((bx + jx, by + jy))

    cols = grid_x + 3
    triangles = []
    for gy in range(grid_y + 2):
        for gx in range(grid_x + 2):
            i = gy * cols + gx
            if gx + 1 < cols and gy + 1 < (grid_y + 3):
                i_right = i + 1
                i_below = i + cols
                i_diag = i + cols + 1
                if i_right < len(points) and i_below < len(points):
                    triangles.append((i, i_right, i_below))
                if i_right < len(points) and i_diag < len(points):
                    triangles.append((i_right, i_diag, i_below))

    for tri in triangles:
        if all(idx < len(points) for idx in tri):
            pts = [points[idx] for idx in tri]
            shade = random.randint(35, 60)
            color = (shade, shade, shade)
            alpha = random.uniform(0.4, 0.8)
            draw_triangle_edges(pixels, pts, color, alpha, thickness=1)

    import math
    for _ in range(12):
        x = random.randint(0, WIDTH)
        y = random.randint(0, HEIGHT)
        angle = random.uniform(0, 3.14159)
        length = random.randint(200, 700)
        x1 = int(x + length * math.cos(angle))
        y1 = int(y + length * math.sin(angle))
        shade = random.randint(30, 50)
        draw_line(pixels, x, y, x1, y1, (shade, shade, shade),
                  alpha=random.uniform(0.4, 0.7), thickness=1)

    raw_data = bytearray()
    for row in pixels:
        raw_data.append(0)
        for r, g, b in row:
            raw_data.extend((r, g, b))

    def write_png(path, width, height, raw):
        def chunk(ctype, data):
            c = ctype + data
            return struct.pack(">I", len(data)) + c + struct.pack(">I", zlib.crc32(c) & 0xFFFFFFFF)

        sig = b"\x89PNG\r\n\x1a\n"
        ihdr = struct.pack(">IIBBBBB", width, height, 8, 2, 0, 0, 0)
        compressed = zlib.compress(bytes(raw), 9)

        with open(path, "wb") as f:
            f.write(sig)
            f.write(chunk(b"IHDR", ihdr))
            f.write(chunk(b"IDAT", compressed))
            f.write(chunk(b"IEND", b""))

    os.makedirs(os.path.dirname(output_path) or ".", exist_ok=True)
    write_png(output_path, WIDTH, HEIGHT, raw_data)
    print(f"Wallpaper saved: {output_path}")


if __name__ == "__main__":
    out = sys.argv[1] if len(sys.argv) > 1 else os.path.expanduser(
        "~/Pictures/wallpaper/grayscale-geo.png"
    )
    generate_wallpaper(out)
