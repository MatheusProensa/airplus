package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class MyIssuesView implements IIssueBrowserView
   {
      private var UnknownVarFromMyIssuesView_IssueManager_1:IssueManager;
      
      private var UnknownVarFromMyIssuesView_IssueBrowser_1:IssueBrowser;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromMyIssuesView_IssueListView_1:IssueListView;
      
      public function MyIssuesView(param1:IssueManager, param2:IssueBrowser, param3:IWindowController_1)
      {
         super();
         UnknownVarFromMyIssuesView_IssueManager_1 = param1;
         UnknownVarFromMyIssuesView_IssueBrowser_1 = param2;
         _window = param3;
         _window.visible = false;
         var _loc5_:IItemListWindow = _window.findChildByName("issue_list") as IItemListWindow;
         UnknownVarFromMyIssuesView_IssueListView_1 = new IssueListView(param1,param2,_loc5_);
         var _loc4_:IWindowModel = _window.findChildByName("release_all");
         if(_loc4_ != null)
         {
            _loc4_.addEventListener("WME_CLICK",onReturnAll);
         }
      }
      
      public function get view() : IWindowController_1
      {
         return _window;
      }
      
      public function set visible(param1:Boolean) : void
      {
         _window.visible = param1;
      }
      
      public function update() : void
      {
         var _loc1_:Array = UnknownVarFromMyIssuesView_IssueManager_1.getBundles("issue_bundle_my");
         UnknownVarFromMyIssuesView_IssueListView_1.update(_loc1_);
      }
      
      private function onReturnAll(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromMyIssuesView_IssueManager_1 == null)
         {
            return;
         }
         UnknownVarFromMyIssuesView_IssueManager_1.releaseAll();
      }
   }
}

