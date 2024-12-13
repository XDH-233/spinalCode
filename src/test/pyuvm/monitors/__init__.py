from pyuvm import uvm_component, uvm_analysis_port


class AvstMonitor(uvm_component):

    def __init__(self, name, parent):
        super().__init__(name, parent)

    def build_phase(self):
        self.ap = uvm_analysis_port("ap", self)
        self.bfm = None #TODO

    def run_phase(self):
        while True:
            pass