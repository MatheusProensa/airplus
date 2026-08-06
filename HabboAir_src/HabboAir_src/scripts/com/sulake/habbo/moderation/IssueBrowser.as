package com.sulake.habbo.moderation
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class IssueBrowser
   {
      private const MY_ISSUES:String = "my_issues";
      
      private const OPEN_ISSUES:String = "open_issues";
      
      private const PICKED_ISSUES:String = "picked_issues";
      
      private const CLOSED_ISSUES:String = "closed_issues";
      
      private var _issueManager:IssueManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _assets:IAssetLibraryCollection;
      
      private var _window:IFrameController;
      
      private var _tabContext:ITabContextWindow;
      
      private var UnknownVarFromIssueBrowser_IIssueBrowserView_1:IIssueBrowserView;
      
      private var UnknownVarFromIssueBrowser_IIssueBrowserView_2:IIssueBrowserView;
      
      private var UnknownVarFromIssueBrowser_IIssueBrowserView_3:IIssueBrowserView;
      
      private var UnknownVarFromIssueBrowser_PickedIssuesView_1:PickedIssuesView;
      
      public function IssueBrowser(param1:IssueManager, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection)
      {
         super();
         _issueManager = param1;
         _windowManager = param2;
         _assets = param3;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get assets() : IAssetLibraryCollection
      {
         return _assets;
      }
      
      public function get issueManager() : IssueManager
      {
         return _issueManager;
      }
      
      public function show() : void
      {
         if(_window == null)
         {
            createMainFrame();
         }
         _window.visible = true;
         _window.activate();
         update();
      }
      
      public function isOpen() : Boolean
      {
         return _window != null && Boolean(_window.visible);
      }
      
      private function createMainFrame() : void
      {
         var _loc1_:IWindowModel = null;
         var _loc5_:IWindowModel = null;
         var _loc6_:IWindowModel = null;
         var _loc2_:ITabButtonWindow = null;
         var _loc4_:int = 0;
         if(_window == null)
         {
            _window = createWindow("issue_browser_xml") as IFrameController;
            if(_window == null)
            {
               return;
            }
            _loc1_ = _window.desktop;
            _window.x = _loc1_.width / 2 - _window.width / 2;
            _window.y = _loc1_.height / 2 - _window.height / 2;
            _loc5_ = _window.findChildByTag("close");
            if(_loc5_ != null)
            {
               _loc5_.addEventListener("WME_CLICK",onClose);
            }
            _loc6_ = _window.findChildByName("auto_pick");
            if(_loc6_ != null)
            {
               _loc6_.addEventListener("WME_CLICK",onAutoPick);
            }
            _tabContext = _window.findChildByName("tab_context") as ITabContextWindow;
            _loc4_ = 0;
            while(_loc4_ < _tabContext.numTabItems)
            {
               _loc2_ = _tabContext.getTabItemAt(_loc4_);
               _loc2_.addEventListener("WE_SELECTED",onTabSelected);
               _loc4_++;
            }
            UnknownVarFromIssueBrowser_IIssueBrowserView_2 = new MyIssuesView(issueManager,this,_window.findChildByName("my_issues_prototype") as IWindowController_1);
            UnknownVarFromIssueBrowser_IIssueBrowserView_3 = new OpenIssuesView(issueManager,this,_window.findChildByName("open_issues_prototype") as IWindowController_1);
            UnknownVarFromIssueBrowser_PickedIssuesView_1 = new PickedIssuesView(issueManager,this,_window.findChildByName("picked_issues_prototype") as IWindowController_1);
         }
         _tabContext = _window.findChildByName("tab_context") as ITabContextWindow;
         if(_tabContext == null || _tabContext.container == null)
         {
            return;
         }
         var _loc3_:ISelectableWindow = _tabContext.selector.getSelectableByName("open_issues");
         _tabContext.selector.setSelected(_loc3_);
      }
      
      private function selectView(param1:String) : void
      {
         var _loc2_:IIssueBrowserView = getView(param1);
         if(UnknownVarFromIssueBrowser_IIssueBrowserView_1 == _loc2_)
         {
            return;
         }
         if(UnknownVarFromIssueBrowser_IIssueBrowserView_1 != null)
         {
            UnknownVarFromIssueBrowser_IIssueBrowserView_1.visible = false;
         }
         UnknownVarFromIssueBrowser_IIssueBrowserView_1 = _loc2_;
         if(UnknownVarFromIssueBrowser_IIssueBrowserView_1 == null)
         {
            return;
         }
         UnknownVarFromIssueBrowser_IIssueBrowserView_1.view.width = _tabContext.container.width;
         UnknownVarFromIssueBrowser_IIssueBrowserView_1.view.height = _tabContext.container.height;
         UnknownVarFromIssueBrowser_IIssueBrowserView_1.visible = true;
         UnknownVarFromIssueBrowser_IIssueBrowserView_1.update();
      }
      
      private function getView(param1:String) : IIssueBrowserView
      {
         switch(param1)
         {
            case "my_issues":
               return UnknownVarFromIssueBrowser_IIssueBrowserView_2;
            case "open_issues":
               return UnknownVarFromIssueBrowser_IIssueBrowserView_3;
            case "picked_issues":
               return UnknownVarFromIssueBrowser_PickedIssuesView_1;
            default:
               return null;
         }
      }
      
      private function onTabSelected(param1:WindowEvent) : void
      {
         if(param1 == null || param1.window == null)
         {
            return;
         }
         selectView(param1.window.name);
      }
      
      public function update() : void
      {
         if(_window == null || !_window.visible)
         {
            return;
         }
         if(UnknownVarFromIssueBrowser_IIssueBrowserView_1 == null)
         {
            return;
         }
         UnknownVarFromIssueBrowser_IIssueBrowserView_1.update();
      }
      
      public function createWindow(param1:String) : IWindowModel
      {
         if(_windowManager == null || _assets == null)
         {
            return null;
         }
         var _loc2_:XmlAsset = _assets.getAssetByName(param1) as XmlAsset;
         if(_loc2_ == null || _loc2_.content == null)
         {
            return null;
         }
         return _windowManager.buildFromXML(_loc2_.content as XML);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         _window.visible = false;
      }
      
      private function onAutoPick(param1:WindowMouseEvent) : void
      {
         if(_issueManager != null)
         {
            _issueManager.autoPick("issue browser pick next");
         }
      }
   }
}

