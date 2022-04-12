# Copyright 2021 The MediaPipe Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load(
    "@build_bazel_rules_apple//apple:ios.bzl",
    "ios_framework",
)

licenses(["notice"])

alias(
    name = "selfiesegmentation",
    actual = "SelfieSegmentation",
)

ios_framework(
    name = "SelfieSegmentation",
    hdrs = [
        "SelfieSegmentation.h",
    ],
    bundle_id = "com.mediapipe.selfiesegmentation",
    families = ["iphone", "ipad"],
    infoplists = ["Info.plist"],
    minimum_os_version = "11.0",
    deps = [
        ":SelfieSegmentationLibrary",
        "@ios_opencv//:OpencvFramework",
    ],
)

objc_library(
    name = "SelfieSegmentationLibrary",
    srcs = [
        "SelfieSegmentation.mm",
    ],
    hdrs = [
        "SelfieSegmentation.h",
    ],
    data = [
        "//mediapipe/graphs/selfie_segmentation:selfie_segmentation_gpu.binarypb",
        "//mediapipe/modules/selfie_segmentation:selfie_segmentation.tflite",
    ],
    deps = [
        "//mediapipe/objc:mediapipe_framework_ios",
        "//mediapipe/objc:mediapipe_input_sources_ios",
        "//mediapipe/objc:mediapipe_layer_renderer",
    ] + select({
        "//mediapipe:ios_i386": [],
        "//mediapipe:ios_x86_64": [],
        "//conditions:default": [
            "//mediapipe/graphs/selfie_segmentation:selfie_segmentation_gpu_deps",
        ],
    }),
)
