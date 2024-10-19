#import the GDB
import gdb
from pygments import highlight
from pygments.lexers import CLexer
from pygments.formatters import TerminalFormatter

# Setting debug in GDB
def run_program():
	print("Running the program...")
	gdb.execute("run")

def stop_program():
	print("Stopping the program...")
	gdb.execute("interrupt")


def set_breakpoint(bp_loc):
    print("Setting Break Point")
    gdb.execute(f"break {bp_loc}") 

class ThreadInfoCommand(gdb.Command):
    """Custom command to print thread information nicely."""
    
    def __init__(self):
        super(ThreadInfoCommand, self).__init__("info_threads_nice", gdb.COMMAND_USER)

    def invoke(self, arg, from_tui):
        # Get the list of threads
        threads = gdb.execute("info threads", to_string=True)
        thread_lines = threads.splitlines()

        print("\n" + " " * 2 + "ID    Target ID                 Frame")
        print("-" * 50)

        # Iterate through each line, skipping the header and empty lines
        for line in thread_lines[2:]:
            if line.strip():  # Skip empty lines
                parts = line.split()
                thread_id = parts[0]  # Thread ID
                target_id = parts[1]  # Target ID
                frame = ' '.join(parts[2:])  # The remaining part is the frame

                # Print in a formatted way
                print(f"{thread_id:<6} {target_id:<25} {frame}")

        print("-" * 50)

class PrettyList(gdb.Command):
    """Print source code with color."""
    
    def __init__(self):
        super(PrettyList, self).__init__("pretty_list", gdb.COMMAND_USER)
        self.lex = CLexer()
        self.fmt = TerminalFormatter()

    def invoke(self, args, tty):
        try:
            # Capture the source code from the 'list' command
            out = gdb.execute(f"list {args}", to_string=True)
            # Highlight the output using Pygments
            print(highlight(out, self.lex, self.fmt))
        except Exception as e:
            print(f"Error: {e}")

class KrvLayout(gdb.Command):
	def __init__(self):
		super(KrvLayout, self).__init__("KrvLayout", gdb.COMMAND_USER)
		self.lex = CLexer()
		self.fmt = TerminalFormatter()

	def invoke(self, args, tty):
		try:
			# Capture the source code from the 'list' command
			gdb.execute("tui enable")  # Changed to capture source code
			# Highlight the output using Pygments
			#print(highlight(out, self.lex, self.fmt))
		except Exception as e:
			print(f"Error: {e}")

def main():
	"""Main script execution - runs the program, stops it, and displays layout."""
	
	PrettyList()
	ThreadInfoCommand()
	KrvLayout()
	
	gdb.execute("break ref_radar_service.cc:11")
	gdb.execute("break ref_radar_service.cc:5")
	
	gdb.execute("run")
	
# Call the main function to execute
if __name__ == "__main__":
    main()
