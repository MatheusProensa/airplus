package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.IViewCtrl;
   import com.sulake.habbo.navigator.UserCountRenderer;
   import com.sulake.habbo.navigator.Util;
   
   public class CategoryListCtrl implements IViewCtrl
   {
      private static const CATEGORY_SPACING:int = 5;
      
      private var UnknownVarFromCategoryListCtrl_UserCountRenderer_1:UserCountRenderer;
      
      private var _navigator:HabboNavigator;
      
      private var _content:IWindowController_1;
      
      private var UnknownVarFromCategoryListCtrl_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromCategoryListCtrl_IScrollbarWindow_1:IScrollbarWindow;
      
      public function CategoryListCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         UnknownVarFromCategoryListCtrl_UserCountRenderer_1 = new UserCountRenderer(_navigator);
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromCategoryListCtrl_UserCountRenderer_1)
         {
            UnknownVarFromCategoryListCtrl_UserCountRenderer_1.dispose();
            UnknownVarFromCategoryListCtrl_UserCountRenderer_1 = null;
         }
      }
      
      public function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc1_:FlatCategory = null;
         var _loc10_:IWindowController_1 = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:Array = _navigator.data.allCategories;
         var _loc7_:Map = _navigator.data.categoriesWithVisitorData.categoryToCurrentUserCountMap;
         var _loc8_:Map = _navigator.data.categoriesWithVisitorData.categoryToMaxUserCountMap;
         var _loc9_:IWindowController_1 = IWindowController_1(UnknownVarFromCategoryListCtrl_IItemListWindow_1.getListItemAt(0));
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc1_ = _loc6_[_loc4_];
            if(_loc1_.visible)
            {
               _loc10_ = getCategoryContainer(_loc9_,_loc4_);
               if(_loc10_ == null)
               {
                  _loc10_ = createEntry(_loc4_);
                  _loc10_.id = _loc4_;
                  _loc9_.addChild(_loc10_);
               }
               _loc2_ = _loc7_.getValue(_loc1_.nodeId);
               _loc5_ = _loc8_.getValue(_loc1_.nodeId);
               refreshEntry(_loc10_,_loc1_,_loc2_,_loc5_);
               _loc10_.y = _loc3_;
               _loc3_ += _loc10_.height + 5;
               _loc10_.visible = true;
               _loc9_.height = Util.getLowestPoint(_loc9_) > 0 ? Util.getLowestPoint(_loc9_) + 5 : 0;
            }
            _loc4_++;
         }
         if(UnknownVarFromCategoryListCtrl_IScrollbarWindow_1 != null)
         {
            UnknownVarFromCategoryListCtrl_IScrollbarWindow_1.scrollV = 0;
            UnknownVarFromCategoryListCtrl_IScrollbarWindow_1.visible = true;
         }
      }
      
      public function refreshEntry(param1:IWindowController_1, param2:FlatCategory, param3:int, param4:int) : void
      {
         param1.findChildByName("category_name_txt").caption = param2.visibleName;
         param1.findChildByName("arrow_right_icon").visible = true;
         UnknownVarFromCategoryListCtrl_UserCountRenderer_1.refreshUserCount(param4,IWindowController_1(param1.findChildByName("enter_category_button")),param3,"${navigator.usercounttooltip.users}",297,35);
      }
      
      public function createEntry(param1:int) : IWindowController_1
      {
         var _loc2_:IWindowController_1 = IWindowController_1(_navigator.getXmlWindow("grs_category_selector"));
         setProcedureAndId(_loc2_,param1,"enter_category_button",onSelectCategory);
         _navigator.refreshButton(_loc2_,"navi_room_icon",true,null,0);
         return _loc2_;
      }
      
      private function onSelectCategory(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:FlatCategory = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = _navigator.data.allCategories[param2.id];
            _navigator.mainViewCtrl.startSearch(2,1,"" + _loc3_.nodeId);
         }
      }
      
      private function getCategoryContainer(param1:IWindowController_1, param2:int) : IWindowController_1
      {
         return IWindowController_1(param1.getChildByID(param2));
      }
      
      private function setProcedureAndId(param1:IWindowController_1, param2:int, param3:String, param4:Function) : void
      {
         param1.findChildByName(param3).procedure = param4;
         param1.findChildByName(param3).id = param2;
      }
      
      public function set content(param1:IWindowController_1) : void
      {
         _content = param1;
         UnknownVarFromCategoryListCtrl_IItemListWindow_1 = !!_content ? IItemListWindow(_content.findChildByName("item_list_category")) : null;
         UnknownVarFromCategoryListCtrl_IScrollbarWindow_1 = !!_content ? IScrollbarWindow(_content.findChildByName("scroller")) : null;
      }
      
      public function get content() : IWindowController_1
      {
         return _content;
      }
   }
}

