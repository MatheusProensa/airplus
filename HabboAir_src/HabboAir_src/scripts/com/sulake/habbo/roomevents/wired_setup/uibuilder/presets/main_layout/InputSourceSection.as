package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.IDefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.IWiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SourceTypeSelectorParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.IconButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.MiniAssetIconButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SourceTypeSelectorPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.AbstractSectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class InputSourceSection extends AbstractSectionPreset implements IWiredInputSourcePicker
   {
      private var UnknownVarFromInputSourceSection_WiredUIPreset_1:WiredUIPreset;
      
      private var UnknownVarFromInputSourceSection_SimpleListViewPreset_1:SimpleListViewPreset;
      
      private var UnknownVarFromInputSourceSection_TextPreset_1:TextPreset;
      
      private var _picker:WiredInputSourcePicker;
      
      private var UnknownVarFromInputSourceSection_IconButtonPreset_1:IconButtonPreset;
      
      private var UnknownVarFromInputSourceSection_IconButtonPreset_2:IconButtonPreset;
      
      private var _furniPicking1Button:MiniAssetIconButtonPreset = null;
      
      private var _furniPicking2Button:MiniAssetIconButtonPreset = null;
      
      public function InputSourceSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:int, param6:int, param7:Array, param8:Boolean = false, param9:Boolean = false)
      {
         var param:SectionParam;
         var roomEvents:HabboUserDefinedRoomEvents = param1;
         var presetManager:PresetManager = param2;
         var wiredStyle:WiredStyle = param3;
         var title:String = param4;
         var sourceType:int = param5;
         var id:int = param6;
         var sourceOptionIds:Array = param7;
         var hasCustomTypePicker:Boolean = param8;
         var dualFurniPickingMode:Boolean = param9;
         super(roomEvents,presetManager,wiredStyle);
         _picker = new WiredInputSourcePicker(roomEvents,sourceType,id);
         UnknownVarFromInputSourceSection_IconButtonPreset_1 = presetManager.createIconButtonPreset("left",function():void
         {
            _picker.onChangeInputSource(false);
            updateUI();
         });
         UnknownVarFromInputSourceSection_TextPreset_1 = presetManager.createText("",new TextParam(1,false,0,false,"center"));
         UnknownVarFromInputSourceSection_IconButtonPreset_2 = presetManager.createIconButtonPreset("right",function():void
         {
            _picker.onChangeInputSource(true);
            updateUI();
         });
         UnknownVarFromInputSourceSection_SimpleListViewPreset_1 = presetManager.createSimpleListView(false,[UnknownVarFromInputSourceSection_IconButtonPreset_1,UnknownVarFromInputSourceSection_TextPreset_1,UnknownVarFromInputSourceSection_IconButtonPreset_2],true);
         UnknownVarFromInputSourceSection_SimpleListViewPreset_1.minHeight = wiredStyle.inputSourceListMinHeight;
         UnknownVarFromInputSourceSection_SimpleListViewPreset_1.spacing = wiredStyle.LRContainerSpacing;
         UnknownVarFromInputSourceSection_WiredUIPreset_1 = presetManager.createPaddedContainerPreset(UnknownVarFromInputSourceSection_SimpleListViewPreset_1,wiredStyle.LRContainerMargin,wiredStyle.LRContainerTopBottomPadding,wiredStyle.LRContainerMargin,wiredStyle.LRContainerTopBottomPadding);
         param = null;
         if(sourceType == WiredInputSourcePicker.MERGED_SOURCE && !hasCustomTypePicker)
         {
            param = new SectionParam(new SourceTypeSelectorParam(sourceOptionIds,this));
         }
         if(dualFurniPickingMode)
         {
            if(param == null)
            {
               param = new SectionParam();
            }
            _furniPicking1Button = presetManager.createMiniAssetIconButtonPreset("furni_picks_1","${wiredfurni.params.furni_picking.tooltip}",onFurniPicks1Clicked);
            _furniPicking2Button = presetManager.createMiniAssetIconButtonPreset("furni_picks_2","${wiredfurni.params.furni_picking.tooltip}",onFurniPicks2Clicked);
            param.addHeaderOption(_furniPicking1Button);
            param.addHeaderOption(_furniPicking2Button);
         }
         initializeSection(title,UnknownVarFromInputSourceSection_WiredUIPreset_1,param);
      }
      
      private function onFurniPicks1Clicked() : void
      {
         _roomEvents.wiredCtrl.activeFurniPicks = 1;
      }
      
      private function onFurniPicks2Clicked() : void
      {
         _roomEvents.wiredCtrl.activeFurniPicks = 2;
      }
      
      public function activeFurniPicksChanged() : void
      {
         if(_furniPicking1Button != null && _furniPicking1Button.visible)
         {
            _furniPicking1Button.selected = _roomEvents.wiredCtrl.activeFurniPicks == 1;
         }
         else if(_furniPicking2Button != null && _furniPicking2Button.visible)
         {
            _furniPicking2Button.selected = _roomEvents.wiredCtrl.activeFurniPicks == 2;
         }
      }
      
      public function refresh(param1:Triggerable, param2:IDefaultElement) : void
      {
         _picker.refreshContainer(param1,param2);
         updateUI();
      }
      
      public function updateUI() : void
      {
         disabled = _picker.disabled;
         UnknownVarFromInputSourceSection_IconButtonPreset_1.disabled = _picker.isButtonsDisabled;
         UnknownVarFromInputSourceSection_IconButtonPreset_2.disabled = _picker.isButtonsDisabled;
         UnknownVarFromInputSourceSection_TextPreset_1.text = _picker.selectedText;
         if(_furniPicking1Button != null && _furniPicking2Button != null)
         {
            switch(_picker.stuffPickingSpecialMode)
            {
               case WiredInputSourcePicker.STUFF_PICKING_MODE_1:
                  _furniPicking1Button.visible = true;
                  _furniPicking2Button.visible = false;
                  _furniPicking1Button.selected = _roomEvents.wiredCtrl.activeFurniPicks == 1;
                  break;
               case WiredInputSourcePicker.STUFF_PICKING_MODE_2:
                  _furniPicking1Button.visible = false;
                  _furniPicking2Button.visible = true;
                  _furniPicking2Button.selected = _roomEvents.wiredCtrl.activeFurniPicks == 2;
                  break;
               default:
                  _furniPicking1Button.visible = false;
                  _furniPicking2Button.visible = false;
            }
         }
         UnknownVarFromAbstractSectionPreset_SectionPreset_1.refreshAlignments();
      }
      
      public function get baseSourceType() : int
      {
         return _picker.sourceType;
      }
      
      public function get id() : int
      {
         return _picker.id;
      }
      
      public function set sourceType(param1:int) : void
      {
         _picker.sourceType = param1;
         var _loc2_:SourceTypeSelectorPreset = UnknownVarFromAbstractSectionPreset_SectionPreset_1.getSourceTypeSelector();
         if(_loc2_ != null)
         {
            _loc2_.select(param1);
         }
         updateUI();
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         UnknownVarFromInputSourceSection_WiredUIPreset_1 = null;
         UnknownVarFromInputSourceSection_SimpleListViewPreset_1 = null;
         UnknownVarFromInputSourceSection_TextPreset_1 = null;
         _picker.dispose();
         _picker = null;
         UnknownVarFromInputSourceSection_IconButtonPreset_1 = null;
         UnknownVarFromInputSourceSection_IconButtonPreset_2 = null;
      }
   }
}

