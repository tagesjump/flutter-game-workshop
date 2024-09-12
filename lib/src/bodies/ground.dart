import 'package:v2/src/bodies/base_body.dart';

/// Компонент земля - игрок не может преодолеть препятствие
/// Этот компонент не имеет отрисовки и может использоваться для создания любых непреодолимых препятствий.
class Ground extends BaseBody {
  Ground({required super.position, super.size, super.polygon});
}
