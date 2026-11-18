// Copyright 2026 LiveKit, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter_test/flutter_test.dart';

import 'package:livekit_client/src/track/options.dart';
import 'package:livekit_client/src/types/video_parameters.dart';

void main() {
  group('CameraCaptureOptions frameRate constraint', () {
    // flutter_webrtc's native getUserMedia reads `frameRate` as a plain number
    // or `{ideal: n}`. It drops `{max: n}` and opens the camera at 30 fps.
    test('maxFrameRate reaches native as a plain number', () {
      for (final fps in [15.0, 25.0, 60.0]) {
        final constraints = CameraCaptureOptions(maxFrameRate: fps).toMediaConstraintsMap();

        expect(constraints['frameRate'], fps);
      }
    });

    test('without maxFrameRate the frame rate comes from params', () {
      final constraints = const CameraCaptureOptions(
        params: VideoParametersPresets.h540_169,
      ).toMediaConstraintsMap();

      expect(constraints['frameRate'], VideoParametersPresets.h540_169.encoding!.maxFramerate);
    });
  });
}
