#import the GDB
import gdb

from pygments import highlight
from pygments.lexers import CLexer
from pygments.formatters import TerminalFormatter

def run_program():
    """
    Runs the program being debugged.
    """
    print("Running the program...")
    gdb.execute("run")

def stop_program():
    """
    Stops the program being debugged (e.g., when it's running).
    This can be done by interrupting the process, similar to Ctrl+C.
    """
    print("Stopping the program...")
    gdb.execute("interrupt")

def display_layout():
    """
    Switches to the TUI (Text User Interface) layout in GDB.
    """
    print("Switching to TUI layout...")
    gdb.execute("layout src")
    gdb.execute("set print pretty on")
    gdb.execute("tui disable")    
    gdb.execute("tui enable")

def set_breakpoint(bp_loc):
    print("setting Break Point")
    gdb.execute(f"break {bp_loc}") 


class ThreadInfoCommand(gdb.Command):
    """Custom command to print thread information nicely."""
    
    def __init__(self):
        super(ThreadInfoCommand, self).__init__("info_threads_nice", gdb.COMMAND_USER)

    def invoke(self, arg, from_tui):
        # Get the list of threads
        threads = gdb.execute("info threads", to_string=True)
        # Split the output into lines
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
        super(PrettyList, self).__init__("preety_list", gdb.COMMAND_USER)
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


def main():
    """
    Main script execution - runs the program, stops it, and displays layout.
    """
    # run_program()
    
    # Pause for demonstration purposes (e.g., wait for the program to start).
    # gdb.execute("shell sleep 2")
    # stop_program()
    
    

    # Switch to TUI layout after stopping the program.
   
    PrettyList()
    ThreadInfoCommand()

    set_breakpoint("main")
    run_program()
    
    
    gdb.execute("break DiscoverARS548RefRadar")

    display_layout() # Call this last or GDB is screw up 

# Execute the main function when the script is sourced in GDB.
main()
