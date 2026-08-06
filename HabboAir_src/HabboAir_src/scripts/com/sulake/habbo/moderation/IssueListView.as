package com.sulake.habbo.moderation
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
   import flash.display.BitmapData;
   import flash.utils.getTimer;
   
   public class IssueListView
   {
      private var UnknownVarFromIssueListView_IssueManager_1:IssueManager;
      
      private var UnknownVarFromIssueListView_IssueBrowser_1:IssueBrowser;
      
      private var UnknownVarFromIssueListView_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromIssueListView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromIssueListView_BitmapData_1:BitmapData;
      
      private var UnknownVarFromIssueListView_BitmapData_2:BitmapData;
      
      private var _issueListLimit:int = 200;
      
      public function IssueListView(param1:IssueManager, param2:IssueBrowser, param3:IItemListWindow)
      {
         super();
         UnknownVarFromIssueListView_IssueManager_1 = param1;
         UnknownVarFromIssueListView_IssueBrowser_1 = param2;
         UnknownVarFromIssueListView_IItemListWindow_1 = param3;
         UnknownVarFromIssueListView_IWindowController_1_1 = param3.getListItemAt(0) as IWindowController_1;
         param3.removeListItems();
         _issueListLimit = param1.issueListLimit;
      }
      
      public function update(param1:Array) : void
      {
         var _loc9_:int = 0;
         var _loc2_:IWindowController_1 = null;
         var _loc3_:IWindowModel = null;
         var _loc14_:IWindowModel = null;
         var _loc12_:* = null;
         var _loc6_:IssueMessageData = null;
         var _loc8_:IBitmapWrapperController = null;
         var _loc10_:String = null;
         var _loc11_:BitmapDataAsset = null;
         var _loc4_:BitmapData = null;
         if(UnknownVarFromIssueListView_IItemListWindow_1 == null)
         {
            return;
         }
         if(param1 == null || param1.length == 0)
         {
            UnknownVarFromIssueListView_IItemListWindow_1.destroyListItems();
            return;
         }
         param1.sortOn(["highestPriority","issueAgeInMilliseconds"],[16,16]);
         var _loc13_:int = UnknownVarFromIssueListView_IItemListWindow_1.numListItems;
         var _loc5_:int = int(param1.length);
         if(_loc5_ > _issueListLimit)
         {
            _loc5_ = _issueListLimit;
         }
         if(_loc13_ < _loc5_)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc5_ - _loc13_)
            {
               _loc2_ = UnknownVarFromIssueListView_IWindowController_1_1.clone() as IWindowController_1;
               UnknownVarFromIssueListView_IItemListWindow_1.addListItem(_loc2_);
               _loc9_++;
            }
         }
         else if(_loc13_ > _loc5_)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc13_ - _loc5_)
            {
               _loc3_ = UnknownVarFromIssueListView_IItemListWindow_1.removeListItemAt(0);
               _loc3_.dispose();
               _loc9_++;
            }
         }
         _loc9_ = 1;
         var _loc7_:int = getTimer();
         for each(_loc12_ in param1)
         {
            if(_loc9_ > _issueListLimit)
            {
               break;
            }
            if(_loc12_ == null || UnknownVarFromIssueListView_IWindowController_1_1 == null)
            {
               return;
            }
            _loc2_ = UnknownVarFromIssueListView_IItemListWindow_1.getListItemAt(_loc9_ - 1) as IWindowController_1;
            if(_loc2_ == null)
            {
               return;
            }
            _loc2_.width = UnknownVarFromIssueListView_IItemListWindow_1.width;
            _loc2_.color = !!(_loc9_++ % 2) ? 4289914618 : 4294967295;
            _loc14_ = _loc2_.findChildByName("score");
            if(_loc14_ != null)
            {
               _loc14_.caption = _loc12_.highestPriority.toString();
            }
            _loc6_ = _loc12_.getHighestPriorityIssue();
            if(_loc6_ == null)
            {
               return;
            }
            _loc14_ = _loc2_.findChildByName("source");
            if(_loc14_ != null)
            {
               _loc14_.caption = IssueCategoryNames.getSourceName(_loc6_.categoryId);
            }
            _loc14_ = _loc2_.findChildByName("category");
            if(_loc14_ != null)
            {
               _loc14_.caption = IssueCategoryNames.getCategoryName(_loc6_.reportedCategoryId);
            }
            _loc14_ = _loc2_.findChildByName("target_name");
            if(_loc14_ != null)
            {
               if(_loc6_.reportedUserId != 0)
               {
                  _loc14_.caption = _loc6_.reportedUserName;
               }
               else
               {
                  _loc14_.caption = "";
               }
            }
            _loc8_ = _loc2_.findChildByName("target_icon") as IBitmapWrapperController;
            if(_loc8_ != null)
            {
               _loc10_ = !!_loc6_.reportedUserId ? "user_icon_png" : "room_icon_png";
               _loc11_ = UnknownVarFromIssueListView_IssueBrowser_1.assets.getAssetByName(_loc10_) as BitmapDataAsset;
               if(_loc11_ != null && _loc11_.content as BitmapData != null)
               {
                  _loc4_ = _loc11_.content as BitmapData;
                  if(_loc4_ != null)
                  {
                     _loc8_.bitmap = _loc4_.clone();
                  }
               }
            }
            _loc14_ = _loc2_.findChildByName("time");
            if(_loc14_ != null)
            {
               _loc14_.caption = _loc12_.getOpenTime(_loc7_);
            }
            _loc14_ = _loc2_.findChildByName("msgs");
            if(_loc14_ != null)
            {
               _loc14_.caption = _loc12_.getMessageCount().toString();
            }
            _loc14_ = _loc2_.findChildByName("picker");
            if(_loc14_ != null)
            {
               _loc14_.caption = _loc12_.pickerName;
            }
            _loc14_ = _loc2_.findChildByName("pick_button");
            if(_loc14_ != null)
            {
               _loc14_.id = _loc12_.id;
               _loc14_.removeEventListener("WME_CLICK",onPick);
               _loc14_.addEventListener("WME_CLICK",onPick);
            }
            _loc14_ = _loc2_.findChildByName("handle_button");
            if(_loc14_ != null)
            {
               _loc14_.id = _loc12_.id;
               _loc14_.removeEventListener("WME_CLICK",onHandle);
               _loc14_.addEventListener("WME_CLICK",onHandle);
            }
            _loc14_ = _loc2_.findChildByName("release_button");
            if(_loc14_ != null)
            {
               _loc14_.id = _loc12_.id;
               _loc14_.removeEventListener("WME_CLICK",onRelease);
               _loc14_.addEventListener("WME_CLICK",onRelease);
            }
         }
      }
      
      private function onPick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromIssueListView_IssueManager_1 == null)
         {
            return;
         }
         UnknownVarFromIssueListView_IssueManager_1.pickBundle(param1.window.id,"pick button");
      }
      
      private function onHandle(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromIssueListView_IssueBrowser_1 == null)
         {
            return;
         }
         UnknownVarFromIssueListView_IssueManager_1.handleBundle(param1.window.id);
      }
      
      private function onRelease(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromIssueListView_IssueManager_1 == null)
         {
            return;
         }
         UnknownVarFromIssueListView_IssueManager_1.releaseBundle(param1.window.id);
      }
   }
}

