package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.window.*;
   import com.sulake.core.window.components.*;
   import com.sulake.core.window.enum.*;
   import com.sulake.core.window.events.*;
   import com.sulake.habbo.communication.messages.incoming.navigator.PopularTagData;
   import com.sulake.habbo.navigator.*;
   
   public class PopularTagsListCtrl implements IViewCtrl
   {
      private var _navigator:HabboNavigator;
      
      private var _content:IWindowController_1;
      
      private var UnknownVarFromPopularTagsListCtrl_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromPopularTagsListCtrl_Int_1:int;
      
      private var UnknownVarFromPopularTagsListCtrl_TagRenderer_1:TagRenderer;
      
      public function PopularTagsListCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         UnknownVarFromPopularTagsListCtrl_TagRenderer_1 = new TagRenderer(_navigator);
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromPopularTagsListCtrl_TagRenderer_1)
         {
            UnknownVarFromPopularTagsListCtrl_TagRenderer_1.dispose();
            UnknownVarFromPopularTagsListCtrl_TagRenderer_1 = null;
         }
      }
      
      public function set content(param1:IWindowController_1) : void
      {
         _content = param1;
         UnknownVarFromPopularTagsListCtrl_IItemListWindow_1 = !!_content ? IItemListWindow(_content.findChildByName("item_list")) : null;
      }
      
      public function get content() : IWindowController_1
      {
         return _content;
      }
      
      public function refresh() : void
      {
         var _loc3_:int = 0;
         var _loc1_:PopularTagData = null;
         UnknownVarFromPopularTagsListCtrl_TagRenderer_1.useHashTags = true;
         var _loc4_:Array = _navigator.data.popularTags.tags;
         var _loc2_:IWindowController_1 = IWindowController_1(UnknownVarFromPopularTagsListCtrl_IItemListWindow_1.getListItemAt(0));
         if(_loc2_ == null)
         {
            _loc2_ = IWindowController_1(_navigator.getXmlWindow("grs_popular_tag_row"));
            UnknownVarFromPopularTagsListCtrl_IItemListWindow_1.addListItem(_loc2_);
         }
         Util.hideChildren(_loc2_);
         _loc3_ = 0;
         while(_loc3_ < _navigator.data.popularTags.tags.length)
         {
            _loc1_ = _navigator.data.popularTags.tags[_loc3_];
            UnknownVarFromPopularTagsListCtrl_TagRenderer_1.refreshTag(_loc2_,_loc3_,_loc1_.tagName);
            _loc3_++;
         }
         Util.layoutChildrenInArea(_loc2_,_loc2_.width,18,3);
         _loc2_.height = Util.getLowestPoint(_loc2_);
         _content.findChildByName("no_tags_found").visible = _loc4_.length < 1;
      }
      
      private function refreshTagName(param1:IWindowController_1, param2:PopularTagData) : void
      {
         var _loc3_:String = "txt";
         var _loc4_:ITextWindow = ITextWindow(param1.findChildByName(_loc3_));
         if(param2 == null)
         {
            return;
         }
         _loc4_.visible = true;
         _loc4_.text = param2.tagName;
      }
   }
}

