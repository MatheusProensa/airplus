package com.sulake.habbo.window.utils.floorplaneditor
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.layout.UpdateFloorPropertiesMessageComposer;
   
   public class ImportExportDialog
   {
      private var _bcFloorPlanEditor:BCFloorPlanEditor;
      
      private var _layout:XML;
      
      private var _window:IFrameController = null;
      
      public function ImportExportDialog(param1:BCFloorPlanEditor, param2:XML)
      {
         super();
         _bcFloorPlanEditor = param1;
         _layout = param2;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(_window == null)
         {
            _window = IFrameController(_bcFloorPlanEditor.windowManager.buildFromXML(_layout));
            _window.center();
            _window.procedure = windowProcedure;
         }
         if(param1)
         {
            _window.visible = true;
            _window.findChildByName("data").caption = _bcFloorPlanEditor.floorPlanCache.getData();
            if(_bcFloorPlanEditor.bcSecondsLeft > 0 || _bcFloorPlanEditor.windowManager.sessionDataManager.hasSecurity(4))
            {
               _window.findChildByName("save").enable();
            }
            else
            {
               _window.findChildByName("save").disable();
            }
            _window.activate();
         }
         else
         {
            _window.visible = false;
         }
      }
      
      public function get visible() : Boolean
      {
         if(!_window)
         {
            return false;
         }
         return _window.visible;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "header_button_close":
                  visible = false;
                  break;
               case "revert":
                  _window.findChildByName("data").caption = _bcFloorPlanEditor.lastReceivedFloorPlan;
                  break;
               case "save":
                  _bcFloorPlanEditor.windowManager.communication.connection.send(new UpdateFloorPropertiesMessageComposer(_window.findChildByName("data").caption,_bcFloorPlanEditor.floorPlanCache.entryPoint.x,_bcFloorPlanEditor.floorPlanCache.entryPoint.y,_bcFloorPlanEditor.floorPlanCache.entryPointDir,BCFloorPlanEditor.getThicknessSettingBySelectionIndex(_bcFloorPlanEditor.wallThickness),BCFloorPlanEditor.getThicknessSettingBySelectionIndex(_bcFloorPlanEditor.floorThickness)));
            }
         }
      }
   }
}

