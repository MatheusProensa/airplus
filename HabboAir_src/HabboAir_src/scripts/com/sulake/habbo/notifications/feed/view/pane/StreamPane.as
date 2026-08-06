package com.sulake.habbo.notifications.feed.view.pane
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.notifications.feed.NotificationView;
   import com.sulake.habbo.notifications.feed.view.content.IFeedEntity;
   
   public class StreamPane extends AbstractPane
   {
      private var UnknownVarFromStreamPane_IItemListWindow_1:IItemListWindow;
      
      public function StreamPane(param1:String, param2:NotificationView, param3:IWindowController_1)
      {
         super(param1,param2,param3,1);
         UnknownVarFromStreamPane_IItemListWindow_1 = _window.findChildByName("list") as IItemListWindow;
      }
      
      override public function dispose() : void
      {
         UnknownVarFromStreamPane_IItemListWindow_1 = null;
         super.dispose();
      }
      
      public function addItem(param1:IFeedEntity) : void
      {
         UnknownVarFromStreamPane_IItemListWindow_1.addListItem(param1.window);
      }
   }
}

