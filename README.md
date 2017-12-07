# LXYOpenListTableView
多级列表展开demo

LXYOpenListTableView.m文件中就是展开列表的代码，可以直接拿.h和.m文件过去使用和修改。

原理是 利用tableview的刷新。每点击一次section的头部，就刷新对应section的cell，然后重新设置cell的高度为0或者实际height。cell的高度为零，就合并；cell的高度为实际cell高度，就是展开。
