package com.sulake.habbo.ui.widget.doorbell
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class DoorbellView
   {
      private var UnknownVarFromDoorbellView_DoorbellWidget_1:DoorbellWidget;
      
      private var _frame:IFrameController;
      
      private var UnknownVarFromDoorbellView_IItemListWindow_1:IItemListWindow;
      
      public function DoorbellView(param1:DoorbellWidget)
      {
         super();
         UnknownVarFromDoorbellView_DoorbellWidget_1 = param1;
      }
      
      public function dispose() : void
      {
         UnknownVarFromDoorbellView_IItemListWindow_1 = null;
         UnknownVarFromDoorbellView_DoorbellWidget_1 = null;
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         if(UnknownVarFromDoorbellView_DoorbellWidget_1.users.length == 0)
         {
            hide();
            return;
         }
         if(_frame == null)
         {
            createMainWindow();
         }
         _frame.visible = true;
         if(UnknownVarFromDoorbellView_IItemListWindow_1 != null)
         {
            UnknownVarFromDoorbellView_IItemListWindow_1.destroyListItems();
            _loc1_ = 0;
            while(_loc1_ < UnknownVarFromDoorbellView_DoorbellWidget_1.users.length)
            {
               UnknownVarFromDoorbellView_IItemListWindow_1.addListItem(createListItem(UnknownVarFromDoorbellView_DoorbellWidget_1.users[_loc1_] as String,_loc1_));
               _loc1_++;
            }
         }
      }
      
      public function get mainWindow() : IWindowModel
      {
         return _frame;
      }
      
      private function createListItem(param1:String, param2:int) : IWindowModel
      {
         var _loc5_:IWindowModel = null;
         var _loc4_:XmlAsset = UnknownVarFromDoorbellView_DoorbellWidget_1.assets.getAssetByName("doorbell_list_entry") as XmlAsset;
         var _loc3_:IWindowController_1 = UnknownVarFromDoorbellView_DoorbellWidget_1.windowManager.buildFromXML(_loc4_.content as XML) as IWindowController_1;
         if(_loc3_ == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var _loc6_:ITextWindow = _loc3_.findChildByName("user_name") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.caption = param1;
         }
         _loc3_.name = param1;
         if(param2 % 2 == 0)
         {
            _loc3_.color = 4294967295;
         }
         _loc5_ = _loc3_.findChildByName("accept");
         if(_loc5_ != null)
         {
            _loc5_.addEventListener("WME_CLICK",onButtonClicked);
         }
         _loc5_ = _loc3_.findChildByName("deny");
         if(_loc5_ != null)
         {
            _loc5_.addEventListener("WME_CLICK",onButtonClicked);
         }
         return _loc3_;
      }
      
      private function hide() : void
      {
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
      }
      
      private function createMainWindow() : void
      {
         if(_frame != null)
         {
            return;
         }
         var _loc2_:XmlAsset = UnknownVarFromDoorbellView_DoorbellWidget_1.assets.getAssetByName("doorbell") as XmlAsset;
         _frame = UnknownVarFromDoorbellView_DoorbellWidget_1.windowManager.buildFromXML(_loc2_.content as XML) as IFrameController;
         if(_frame == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         UnknownVarFromDoorbellView_IItemListWindow_1 = _frame.findChildByName("user_list") as IItemListWindow;
         _frame.visible = false;
         var _loc1_:IWindowModel = _frame.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",onClose);
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         UnknownVarFromDoorbellView_DoorbellWidget_1.denyAll();
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:String = param1.window.parent.name;
         switch(param1.window.name)
         {
            case "accept":
               UnknownVarFromDoorbellView_DoorbellWidget_1.accept(_loc2_);
               break;
            case "deny":
               UnknownVarFromDoorbellView_DoorbellWidget_1.deny(_loc2_);
         }
      }
   }
}

