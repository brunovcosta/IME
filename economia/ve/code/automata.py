from axelrod.action import Action
from axelrod.player import Player
C, D = Action.C, Action.D


class Learner(Player):
    # These are various properties for the strategy
    name = 'Learner'
    classifier = {
        'memory_depth': 1,  # Four-Vector = (1.,0.,1.,0.)
        'stochastic': True,
        'makes_use_of': set(),
        'long_run_time': False,
        'inspects_source': False,
        'manipulates_source': False,
        'manipulates_state': True
    }

    # TODO implement learn strategy
    model = {}

    def strategy(self, opponent: Player) -> Action:
        """This is the actual strategy"""
        # First move
        if not self.history:
            return C
        # React to the opponent's last move
        if opponent.history[-1] == D:
            return D
        return C
