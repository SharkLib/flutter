import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
class MultiItemView extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MultiItemStage();
  }

}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;

  final List<Entry> children;
}


// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTranslations(Entry root)
  {

    if (root.children.isEmpty) //return Text(root.title);
      return Column(
        //crossAxisAlignment: CrossAxisAlignment.end,
      //  mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 20,
                width: 100,
                child:Text(root.title,style: TextStyle(fontSize: 8.0, fontFamily: 'Hind')),
              ),
              SizedBox(
                height: 20,
                width: 200,
                child:Text(root.title),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
          SizedBox(
          height: 28,
          width: 100,
          child:Text("French"),
          ),
              SizedBox(
                  height: 20,
                  width: 200,
                  child:CupertinoTextField(
                    placeholder: "French",
                    keyboardType: TextInputType.emailAddress,
                    clearButtonMode: OverlayVisibilityMode.editing,
                    autocorrect: false,
                    key: PageStorageKey('myScrollable'),
                      style: TextStyle(fontSize: 8.0, fontFamily: 'Hind')
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            SizedBox(
            height: 28,
            width: 100,
  child:Text("Spanish"),
  ),
              SizedBox(
                  height: 20,
                  width: 200,
                  child:CupertinoTextField(
                    placeholder: "French",
                    keyboardType: TextInputType.emailAddress,
                    clearButtonMode: OverlayVisibilityMode.editing,
                    autocorrect: false,
                    key: PageStorageKey('myScrollable'),
                      style: TextStyle(fontSize: 8.0, fontFamily: 'Hind')
                  )),
            ],
          )
        ],
      );
      return Column(
        children: [
        SizedBox(
        height: 28,
        width: 200,
        child:Text(root.title)),
    SizedBox(
    height: 28,
    width: 200,
    child:CupertinoTextField(
          placeholder: "French",
          keyboardType: TextInputType.emailAddress,
          clearButtonMode: OverlayVisibilityMode.editing,
          autocorrect: false,
          key: PageStorageKey('myScrollable'),
          )),
  SizedBox(
  height: 28,
  width: 200,
  child:CupertinoTextField(
          placeholder: "English",
          keyboardType: TextInputType.emailAddress,
          clearButtonMode: OverlayVisibilityMode.editing,
          autocorrect: false,
          key: PageStorageKey('myScrollable'),
        )),
  SizedBox(
  height: 28,
  width: 200,
  child:CupertinoTextField(
            placeholder: "Spanish",
            keyboardType: TextInputType.emailAddress,
            clearButtonMode: OverlayVisibilityMode.editing,
            autocorrect: false,
            key: PageStorageKey('myScrollable'),
          )),
        ],
      );
      return CupertinoButton.filled(
          child: Text(
            root.title,
          ),
          onPressed: () {}
      );
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title:
      CupertinoTextField(
        placeholder: "name",
        keyboardType: TextInputType.emailAddress,
        clearButtonMode: OverlayVisibilityMode.editing,
        autocorrect: false,
        key: PageStorageKey('myScrollable'),
      ),
      leading:Icon(Icons.account_balance_wallet),
      children: root.children.map(_buildFields).toList(),
    );
  }
  Widget _buildFields(Entry root)
  {
    if (root.children.isEmpty) return ListTile(title: Text(root.title) ,leading:Icon(Icons.account_balance_wallet),);
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title:
      /*TextField(
          decoration: InputDecoration(
          labelText: root.title
      ),),*/
      Text(root.title),
      leading:Icon(Icons.account_balance_wallet),
      children: root.children.map(_buildTranslations).toList(),
    );
  }


  Widget _buildModules(Entry root)
  {

    if (root.children.isEmpty) return ListTile(title: Text(root.title),leading:Icon(Icons.label),);
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title:
      /*TextField(
          decoration: InputDecoration(
          labelText: root.title
      ),),*/
      Text(root.title,/*style:textTheme.subtitle1,*/),
      leading:Icon(Icons.label),
      children: root.children.map(_buildFields).toList(),
    );
  }

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title:

        Text(root.title),
        leading:Icon(Icons.dehaze),
      children: root.children.map(_buildModules).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return _buildTiles(entry);
  }
}

class MultiItemStage extends State<MultiItemView>
{

  final List<Entry> data = <Entry>[
    Entry(
      'Plate 1 - Subject Visit',
      <Entry>[
        Entry(
          'Module 1 - Common',
          <Entry>[
            Entry('VISITNUM'),
            Entry('SUBJID',
                <Entry>[
                  Entry('Description'),
                  Entry('Prompt'),
                  Entry('Detai'),]),
            Entry('Item A0.3'),
          ],
        ),
        Entry('Module 2 - date'),
        Entry('Module 3 -  esig'),
      ],
    ),
    Entry(
      'Plate 2 - Eligibility',
      <Entry>[
        Entry('Module 2 - date'),
        Entry('Module 3 -  esig'),
      ],
    ),
    Entry(
      'Plate 32 - Demographics',
      <Entry>[
        Entry('Module 2 - date'),
        Entry('Module 3 -  esig'),
        Entry(
          'Filed - Visit date',
          <Entry>[
            Entry('Item C2.0'),
            Entry('Item C2.1'),
            Entry('Item C2.2'),
            Entry('Item C2.3'),
          ],
        ),
      ],
    ),
  ];



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
        EntryItem(data[index]),
    itemCount: data.length,
    );
  }

}
