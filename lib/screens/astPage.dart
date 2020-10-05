import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interpreter/models/apt.dart';
import 'package:flutter_interpreter/models/expVisitor.dart';
import 'package:flutter_interpreter/viewmodel/ExpProvider.dart';
import 'package:graphview/GraphView.dart';
import 'package:provider/provider.dart';

class AstPage extends StatelessWidget {
  static String routeName = '/tree';
  final Graph graph = Graph();
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Abstract Syntax Tree'),
      ),
      body: Consumer<ExpProvider>(builder: (context, value, child) {
        BinTreeVisitor(graph, builder)
          ..visit(value.apt)
          ..show();
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            InteractiveViewer(
                constrained: true,
                boundaryMargin: EdgeInsets.all(100),
                minScale: 0.01,
                maxScale: 5.6,
                child: GraphView(
                  graph: graph,
                  algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                  paint: Paint()
                    ..color = Colors.green
                    ..strokeWidth = 1
                    ..style = PaintingStyle.stroke,
                )),
          ],
        );
      }),
    );
  }
}

class BinTreeVisitor extends ExpVisitor {
  final Graph graph;
  final BuchheimWalkerConfiguration builder;
  Node nv;

  BinTreeVisitor(this.graph, this.builder);

  @override
  void visit(Exp e) {
    if (e == null)
      graph.addNode(Node(getNodeText("")));
    else
      super.visit(e);
  }

  @override
  void visitNumber(NumberExp e) => graph.addNode(Node(getNodeText(e.value.toString())));

  @override
  void visitDiv(DivExp e) => visitOp(e);

  @override
  void visitMinus(MinusExp e) => visitOp(e);

  @override
  void visitPlus(PlusExp e) => visitOp(e);

  @override
  void visitTimes(TimesExp e) => visitOp(e);

  void visitOp(OpExp e) {
    final thisNode = nv == null ? Node(getNodeText(e.myOp())) : nv;
    if (e.left is NumberExp) {
      graph.addEdge(thisNode, Node(getNodeText((e.left as NumberExp).value.toString())));
    } else {
      nv = Node(getNodeText((e.left as OpExp).myOp()));
      graph.addEdge(thisNode, nv);
      e.left.accept(this);
    }
    if (e.right is NumberExp) {
      graph.addEdge(thisNode, Node(getNodeText((e.right as NumberExp).value.toString())));
    } else {
      nv = Node(getNodeText((e.right as OpExp).myOp()));
      graph.addEdge(thisNode, nv);
      e.right.accept(this);
    }
  }

  void show() {
    builder
      ..siblingSeparation = (10)
      ..levelSeparation = (15)
      ..subtreeSeparation = (15)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }

  Widget getNodeText(String text) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.blue[100], spreadRadius: 1),
            ],
          ),
          child: Text(text)),
    );
  }
}
