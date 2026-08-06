package com.sulake.habbo.navigator
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   
   public class TextSearchInputs
   {
      private var _navigator:HabboNavigator;
      
      private var _searchStr:TextFieldManager;
      
      private var UnknownVarFromTextSearchInputs_IDropBaseController_1_1:IDropBaseController_1;
      
      public function TextSearchInputs(param1:HabboNavigator, param2:IWindowController_1)
      {
         var _loc4_:Array = null;
         super();
         _navigator = param1;
         var _loc3_:ITextFieldWindow = ITextFieldWindow(param2.findChildByName("search_str"));
         _searchStr = new TextFieldManager(_navigator,_loc3_,35,searchRooms,_navigator.getText("navigator.search.info"));
         Util.setProc(param2,"search_but",onSearchButtonClick);
         var _loc5_:Boolean = true;
         if(_loc5_)
         {
            UnknownVarFromTextSearchInputs_IDropBaseController_1_1 = param2.findChildByName("search_type") as IDropBaseController_1;
            _loc4_ = [];
            _loc4_.push(_navigator.getText("${navigator.navisel.bydefault}"));
            _loc4_.push(_navigator.getText("${navigator.navisel.byowner}"));
            _loc4_.push(_navigator.getText("${navigator.navisel.byroomname}"));
            _loc4_.push(_navigator.getText("${navigator.navisel.bytag}"));
            _loc4_.push(_navigator.getText("${navigator.navisel.bygroupname}"));
            UnknownVarFromTextSearchInputs_IDropBaseController_1_1.populate(_loc4_);
            UnknownVarFromTextSearchInputs_IDropBaseController_1_1.selection = 0;
         }
      }
      
      public function dispose() : void
      {
         if(_searchStr)
         {
            _searchStr.dispose();
            _searchStr = null;
         }
         _navigator = null;
      }
      
      public function setText(param1:String, param2:int) : void
      {
         _searchStr.setText(param1);
         if(UnknownVarFromTextSearchInputs_IDropBaseController_1_1 != null)
         {
            switch(param2 - 8)
            {
               case 0:
                  UnknownVarFromTextSearchInputs_IDropBaseController_1_1.selection = 0;
                  break;
               case 1:
                  UnknownVarFromTextSearchInputs_IDropBaseController_1_1.selection = 3;
                  break;
               case 2:
                  UnknownVarFromTextSearchInputs_IDropBaseController_1_1.selection = 2;
                  break;
               case 5:
                  UnknownVarFromTextSearchInputs_IDropBaseController_1_1.selection = 4;
                  break;
               case 12:
                  UnknownVarFromTextSearchInputs_IDropBaseController_1_1.selection = 1;
            }
         }
      }
      
      private function onSearchButtonClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         searchRooms();
      }
      
      private function searchRooms() : void
      {
         var _loc1_:String = _searchStr.getText();
         if(_loc1_ == "")
         {
            return;
         }
         if(UnknownVarFromTextSearchInputs_IDropBaseController_1_1 != null)
         {
            switch(UnknownVarFromTextSearchInputs_IDropBaseController_1_1.selection)
            {
               case 0:
                  _navigator.mainViewCtrl.startSearch(5,8,_loc1_);
                  break;
               case 1:
                  _navigator.mainViewCtrl.startSearch(5,20,_loc1_);
                  break;
               case 2:
                  _navigator.mainViewCtrl.startSearch(5,10,_loc1_);
                  break;
               case 3:
                  _navigator.mainViewCtrl.startSearch(5,9,_loc1_);
                  break;
               case 4:
                  _navigator.mainViewCtrl.startSearch(5,13,_loc1_);
            }
         }
         else
         {
            _navigator.mainViewCtrl.startSearch(5,8,_loc1_);
         }
         _navigator.trackNavigationDataPoint("Search","search",_loc1_);
      }
      
      public function get searchStr() : TextFieldManager
      {
         return _searchStr;
      }
   }
}

