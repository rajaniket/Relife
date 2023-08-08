part of flutter_mentions;

class OptionList extends StatelessWidget {
  OptionList({
    required this.data,
    required this.onTap,
    required this.suggestionListHeight,
    this.suggestionBuilder,
    this.suggestionListDecoration,
  });

  final Widget Function(Map<String, dynamic>)? suggestionBuilder;

  final List<Map<String, dynamic>> data;

  final Function(Map<String, dynamic>) onTap;

  final double suggestionListHeight;

  final BoxDecoration? suggestionListDecoration;

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            child: Container(
              decoration: suggestionListDecoration ??
                  BoxDecoration(color: Colors.white),
              constraints: BoxConstraints(
                maxHeight: suggestionListHeight,
                minHeight: 0,
              ),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return false;
                },
                child: ListView.separated(
                  itemCount: data.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 0,
                    );
                  },
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        onTap(data[index]);
                      },
                      child: suggestionBuilder != null
                          ? suggestionBuilder!(data[index])
                          : Container(
                              color: Colors.blue,
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                data[index]['display'],
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                    );
                  },
                ),
              ),
            ),
          )
        : Container();
  }
}
