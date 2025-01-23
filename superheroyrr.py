from PIL.Image import Image, open, fromarray
import os
import sys
import time
import cv2 as cv
import math
from itertools import repeat

BLOCK = '▄'
# colors
BLACK = '\33[90m'
RED = '\33[91m'
GREEN = '\33[92m'
YELLOW = '\33[93m'
BLUE = '\33[94m'
PURPLE = '\33[95m'
CYAN = '\33[96m'

colors = [
    (0, 0, 0),
    (205, 49, 49),
    (13, 188, 121),
    (229, 229, 16),
    (36, 114, 200),
    (188, 63, 188),
    (17, 168, 205),
    (229, 229, 229)
]

bright_colors = [
    (102, 102, 102),
    (241, 76, 76),
    (35, 209, 139),
    (245, 245, 67),
    (59, 142, 234),
    (214, 112, 214),
    (41, 184, 219),
    (229, 229, 229)
]


def closest_color(r: int, g: int, b: int, bg: bool):
    color_distances = [math.sqrt((r - r2) ** 2 + (g - g2) ** 2 + (b - b2) ** 2) for r2, g2, b2 in colors]
    bright_color_distances = [math.sqrt((r - r2) ** 2 + (g - g2) ** 2 + (b - b2) ** 2) for r2, g2, b2 in bright_colors]
    if min(color_distances) < min(bright_color_distances):
        return f'\33[{color_distances.index(min(color_distances)) + 30 + (10 * bg)}m'
    else:
        return f'\33[{bright_color_distances.index(min(bright_color_distances)) + 90 + (10 * bg)}m'


def draw_frame(img: Image):
    string = []
    for y in range(0, img.height, 2):
        for x in range(0, img.width):
            newline = False
            if x == img.width - 1:
                newline = True

            top_pixel = img.getpixel((x, y))
            #string.append(closest_color(*top_pixel[::-1], True))
            string.append('\033[48;2;{};{};{}m'.format(*top_pixel[::-1]))

            try:
                bottom_pixel = img.getpixel((x, y + 1))
            except IndexError:
                pass
            else:
                #string.append(closest_color(*bottom_pixel[::-1], False))
                string.append('\033[38;2;{};{};{}m'.format(*bottom_pixel[::-1]))

            string.append(BLOCK)
        
            if newline:
                string.append('\033[0m')
                string.append('\n')

    return ''.join(string)


file_folder = os.path.dirname(os.path.abspath(__file__))
cap = cv.VideoCapture(file_folder + '/superheroyrr.mp4')
frame_count = cap.get(cv.CAP_PROP_FRAME_COUNT)
target_fps = cap.get(cv.CAP_PROP_FPS)
target_frame_time = 1 / (target_fps + 1)

if sys.argv[-1].isdigit():
    size = int(sys.argv[-1])
else:
    size = 10

frames: list[Image] = []
while True:
    flag, f = cap.read()
    if flag:
        f2 = fromarray(f)
        f2.thumbnail((size, size))
        frames.append(f2)
    else:
        break

for frames2 in repeat(frames):
    for frame in frames2:
        frame_start = time.perf_counter()
        print("\033[0;0H",  draw_frame(frame), sep='', end='', flush=True)
        frame_time = time.perf_counter() - frame_start
        if frame_time < target_frame_time:
            time.sleep(target_frame_time - frame_time)
