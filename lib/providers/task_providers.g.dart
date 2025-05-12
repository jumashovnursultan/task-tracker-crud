// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createTaskHash() => r'fd768a4dcb06bf33eea1a9844d9feac7eb95ffb4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [createTask].
@ProviderFor(createTask)
const createTaskProvider = CreateTaskFamily();

/// See also [createTask].
class CreateTaskFamily extends Family<AsyncValue<ApiResponse<TaskModel>>> {
  /// See also [createTask].
  const CreateTaskFamily();

  /// See also [createTask].
  CreateTaskProvider call(TaskModel model) {
    return CreateTaskProvider(model);
  }

  @override
  CreateTaskProvider getProviderOverride(
    covariant CreateTaskProvider provider,
  ) {
    return call(provider.model);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'createTaskProvider';
}

/// See also [createTask].
class CreateTaskProvider
    extends AutoDisposeFutureProvider<ApiResponse<TaskModel>> {
  /// See also [createTask].
  CreateTaskProvider(TaskModel model)
    : this._internal(
        (ref) => createTask(ref as CreateTaskRef, model),
        from: createTaskProvider,
        name: r'createTaskProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$createTaskHash,
        dependencies: CreateTaskFamily._dependencies,
        allTransitiveDependencies: CreateTaskFamily._allTransitiveDependencies,
        model: model,
      );

  CreateTaskProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.model,
  }) : super.internal();

  final TaskModel model;

  @override
  Override overrideWith(
    FutureOr<ApiResponse<TaskModel>> Function(CreateTaskRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateTaskProvider._internal(
        (ref) => create(ref as CreateTaskRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        model: model,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ApiResponse<TaskModel>> createElement() {
    return _CreateTaskProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateTaskProvider && other.model == model;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, model.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateTaskRef on AutoDisposeFutureProviderRef<ApiResponse<TaskModel>> {
  /// The parameter `model` of this provider.
  TaskModel get model;
}

class _CreateTaskProviderElement
    extends AutoDisposeFutureProviderElement<ApiResponse<TaskModel>>
    with CreateTaskRef {
  _CreateTaskProviderElement(super.provider);

  @override
  TaskModel get model => (origin as CreateTaskProvider).model;
}

String _$editTaskHash() => r'2f564afb22147ee00e6f17c07a09faae63d04125';

/// See also [editTask].
@ProviderFor(editTask)
const editTaskProvider = EditTaskFamily();

/// See also [editTask].
class EditTaskFamily extends Family<AsyncValue<ApiResponse<TaskModel>>> {
  /// See also [editTask].
  const EditTaskFamily();

  /// See also [editTask].
  EditTaskProvider call(TaskModel model) {
    return EditTaskProvider(model);
  }

  @override
  EditTaskProvider getProviderOverride(covariant EditTaskProvider provider) {
    return call(provider.model);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'editTaskProvider';
}

/// See also [editTask].
class EditTaskProvider
    extends AutoDisposeFutureProvider<ApiResponse<TaskModel>> {
  /// See also [editTask].
  EditTaskProvider(TaskModel model)
    : this._internal(
        (ref) => editTask(ref as EditTaskRef, model),
        from: editTaskProvider,
        name: r'editTaskProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$editTaskHash,
        dependencies: EditTaskFamily._dependencies,
        allTransitiveDependencies: EditTaskFamily._allTransitiveDependencies,
        model: model,
      );

  EditTaskProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.model,
  }) : super.internal();

  final TaskModel model;

  @override
  Override overrideWith(
    FutureOr<ApiResponse<TaskModel>> Function(EditTaskRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditTaskProvider._internal(
        (ref) => create(ref as EditTaskRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        model: model,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ApiResponse<TaskModel>> createElement() {
    return _EditTaskProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditTaskProvider && other.model == model;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, model.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EditTaskRef on AutoDisposeFutureProviderRef<ApiResponse<TaskModel>> {
  /// The parameter `model` of this provider.
  TaskModel get model;
}

class _EditTaskProviderElement
    extends AutoDisposeFutureProviderElement<ApiResponse<TaskModel>>
    with EditTaskRef {
  _EditTaskProviderElement(super.provider);

  @override
  TaskModel get model => (origin as EditTaskProvider).model;
}

String _$taskListHash() => r'770ad3881f78aecc7a9d0494c194d7a6fd912073';

abstract class _$TaskList extends BuildlessAutoDisposeNotifier<TaskListState> {
  late final TaskParamsModel? initialParams;

  TaskListState build({TaskParamsModel? initialParams});
}

/// See also [TaskList].
@ProviderFor(TaskList)
const taskListProvider = TaskListFamily();

/// See also [TaskList].
class TaskListFamily extends Family<TaskListState> {
  /// See also [TaskList].
  const TaskListFamily();

  /// See also [TaskList].
  TaskListProvider call({TaskParamsModel? initialParams}) {
    return TaskListProvider(initialParams: initialParams);
  }

  @override
  TaskListProvider getProviderOverride(covariant TaskListProvider provider) {
    return call(initialParams: provider.initialParams);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'taskListProvider';
}

/// See also [TaskList].
class TaskListProvider
    extends AutoDisposeNotifierProviderImpl<TaskList, TaskListState> {
  /// See also [TaskList].
  TaskListProvider({TaskParamsModel? initialParams})
    : this._internal(
        () => TaskList()..initialParams = initialParams,
        from: taskListProvider,
        name: r'taskListProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$taskListHash,
        dependencies: TaskListFamily._dependencies,
        allTransitiveDependencies: TaskListFamily._allTransitiveDependencies,
        initialParams: initialParams,
      );

  TaskListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.initialParams,
  }) : super.internal();

  final TaskParamsModel? initialParams;

  @override
  TaskListState runNotifierBuild(covariant TaskList notifier) {
    return notifier.build(initialParams: initialParams);
  }

  @override
  Override overrideWith(TaskList Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskListProvider._internal(
        () => create()..initialParams = initialParams,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        initialParams: initialParams,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TaskList, TaskListState> createElement() {
    return _TaskListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskListProvider && other.initialParams == initialParams;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, initialParams.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TaskListRef on AutoDisposeNotifierProviderRef<TaskListState> {
  /// The parameter `initialParams` of this provider.
  TaskParamsModel? get initialParams;
}

class _TaskListProviderElement
    extends AutoDisposeNotifierProviderElement<TaskList, TaskListState>
    with TaskListRef {
  _TaskListProviderElement(super.provider);

  @override
  TaskParamsModel? get initialParams =>
      (origin as TaskListProvider).initialParams;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
