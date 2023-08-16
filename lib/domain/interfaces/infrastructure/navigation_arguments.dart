/// Object that clusters all arguments and parameters retrieved or produced during a route search.
abstract class NavigationArguments {
  /// It retrieves parameters after consulting a dynamic route. If it is not a dynamic route the object will be an empty Map.
  /// ex: /asset/:id  ->  /asset/1
  /// NavigationArguments.params['id']; -> '1'
  Map<String, dynamic> get params;

  /// Retrieved from a direct input of arguments from the navigation system itself.
  dynamic get data;
}
